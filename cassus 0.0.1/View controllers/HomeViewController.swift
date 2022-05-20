//
//  Home.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 22/10/2021.
//
import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var deals: [Deal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataLoader().load { [weak self] list in
            guard let self = self else { return }
            self.deals = list.deals
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
  
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    private func openDealDetails(deal: DealDetail) {
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailViewController.deal = deal
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}


// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    //hoeveelheid cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deals.count
    }
    
    //functie data trekken
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DealCollectionViewCell
        
        let deal = deals[indexPath.row]
        
        cell.setup(deal)
        
        DataLoader().downloadImage(urlString: deal.imageURL, indexPath: indexPath) { [weak self] downloadedImage, imageIndexPath in
            self?.updateImage(downloadedImage, forIndexPath: indexPath)
        }
        
        return cell
    }
    
    private func updateImage(_ image: UIImage, forIndexPath indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DealCollectionViewCell {
            cell.updateImage(image)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deal = deals[indexPath.item]
        let unique = deal.unique ?? ""
        
        DetailAPI.getDetails(for: unique) { [weak self] dealDetail in
            self?.openDealDetails(deal: dealDetail)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 394)
    }
}
