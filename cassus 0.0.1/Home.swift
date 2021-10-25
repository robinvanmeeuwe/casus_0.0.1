//
//  Home.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 22/10/2021.
//
import UIKit


class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let CategoryTopMenu = ["Populair", "Favorieten", "Eten & drinken", "Uitjes", "Overnachten", "Wellness & beauty", "Speciaalzaken & auto's", "Sport", "Cursussen & workshops"]
    
    let cardTitle = ["Waardebon voor carnavalsaccesiores", "3-gangen keuzediner bij De Hooghei", "hoi"]
    let imageCard = [UIImage(named: "proefImageDetailCard"), UIImage(named: "proefImageDetailCard"), UIImage(named: "proefImageDetailCard"),]
    let cardDescription = ["Oetel club \n Rosmalen", "De Hooghei \n Berlicum", "Q-Wash \n 's Hertogenbosch"]
    let priceOld = ["10", "12", "14"]
    let priceNew = ["7,50", "10", "12"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "\(title ?? "Den Bosch")"
        self.navigationItem.title = "Den bosch"
        
        
    }
    
    
    
    func title() {
        self.navigationItem.title = "hallo"
    }
    //hoeveelheid carts
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardTitle.count
    }
    //functie data trekken
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        Detailcard
        cell.detailImage.image = imageCard[indexPath.row]
        cell.titleCard.text = cardTitle[indexPath.row]
        cell.describtionCard.text = cardDescription[indexPath.row]
        cell.howManySold.text = "Verkocht: \(String(describing: sold))"
        cell.oldPrice.text = priceOld[indexPath.row]
        cell.newPrice.text = priceNew[indexPath.row]
        
        
        // styling cards
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.backgroundColor = UIColor.white.cgColor
        //cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        //cell.layer.shadowRadius = 4.0
        //cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.detailImage.layer.cornerRadius = 4.0
        
        
        
        return cell
    }
    
    func sold() {
        
    }
}


// MARK: - Test

extension Home: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 394)
    }
}
