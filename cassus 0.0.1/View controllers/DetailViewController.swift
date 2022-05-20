//
//  DetailView.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 04/11/2021.
//

import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var soldDetail: UILabel!
    @IBOutlet var companyNameDetail: UILabel!
    @IBOutlet var locationDetail: UILabel!
    @IBOutlet var newPriceDetail: UILabel!
    @IBOutlet var imageCarouselPageControl: UIPageControl!
    @IBOutlet var oldPriceDetail: UILabel!
    @IBOutlet var descriptionDetail: UILabel!
    @IBOutlet var mapViewDetail: MKMapView!
    @IBOutlet var carousel: UICollectionView!
    @IBOutlet var buyButtonLabel: UILabel!
    @IBOutlet var BuyButton: UIButton!
    
//    var messageLabel: UILabel!
//    var message = "Dit is mijn bericht"
//    var hasMessage: Bool = true
//    var isActive: Bool =  false
    
    @IBOutlet weak private var locationsTableViewHeightConstraint: NSLayoutConstraint!
    
    var deal: DealDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDeal()
        setupMapView()
        setupBackButton()
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupDeal() {
        
        let oldPriceAS: NSMutableAttributedString =  NSMutableAttributedString(string: String(format: "€ %.2f", deal.from))
        oldPriceAS.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, oldPriceAS.length))
        
        titleLabel.text = deal.title
        oldPriceDetail.attributedText = oldPriceAS
        soldDetail.text = "Verkocht: \(deal.sold)"
        
        companyNameDetail.text = deal._embedded.company.name
        newPriceDetail.text = String(format: "€ %.2f", deal.price)
        locationDetail.text = deal.location
        
        
        descriptionDetail.text = deal.name.stripOutHtml()
        descriptionDetail.numberOfLines = 0
        
        carousel.delegate = self
        carousel.dataSource = self
        
        imageCarouselPageControl.numberOfPages = deal.images.count
        imageCarouselPageControl.currentPage = 0
        
        buyButtonLabel.text = String(format: "€ %.2f", deal.price)
        
        
        // Locations
        
        locationsTableViewHeightConstraint.constant = CGFloat(deal._embedded.company.locations.count) * 88
        
    }
    // MARK: - Mapview Setup
    
    func setupMapView() {
        if let location = deal._embedded.company.locations.first {
            let MKMapView = MKPointAnnotation()
            MKMapView.title = deal.title
            MKMapView.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
            mapViewDetail.addAnnotation(MKMapView)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    @IBAction private func didTapPageControl(_ sender: Any) {
        let page = imageCarouselPageControl.currentPage
        let horizontalOffset = carousel.bounds.width * CGFloat(page)
        let offset = CGPoint(x: horizontalOffset, y: 0)
        
        carousel.setContentOffset(offset, animated: true)
    }
    
    
    // MARK: - TopbarLayout
    
    func setupBackButton() {
        
        navigationItem.hidesBackButton = true
        
        let containerView = UIView()

        let label = UILabel()
        label.textColor = .white
        label.text = deal._embedded.company.name
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(backButtonPressed)),
            UIBarButtonItem(customView: containerView)
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "share_icon"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "fav_icon"), style: .plain, target: self, action: nil)
        ]
    }
    
    @IBAction func OnClick(_ sender: Any) {
        
        let buyAlert = UIAlertController(title: "Bevestig u aankoop", message: "weet u zeker dat u dit wil kopen?", preferredStyle: UIAlertController.Style.alert)
        
        buyAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("hier de button verder uit te werken voor wanneer mensen door willen met hun aankoop")
        }))
        
        buyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("hier de button verder uit te werken voor wanneer mensen hun order willen cancelen")
            buyAlert .dismiss(animated: true, completion: nil)
        }))
        
        self.present(buyAlert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deal.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let imageURL = deal.images[indexPath.row]
        
        cell.setup(imageURL: imageURL)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let horizontalOffset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let index = horizontalOffset / width
        let currentPage = round(index)
        
        imageCarouselPageControl.currentPage = Int(currentPage)
    }
}
// MARK: - UITableViewDelagate

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deal._embedded.company.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTabelViewCell", for: indexPath) as!
        LabelTabelViewCell
        
        let location = deal._embedded.company.locations[indexPath.row]
        
        cell.setup(location)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let location = deal._embedded.company.locations[indexPath.row]
        guard let url = URL(string: location.directions) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}
