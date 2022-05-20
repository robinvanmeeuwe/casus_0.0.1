//
//  DealCollectionViewCell.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 25/10/2021.
//

import UIKit

class DealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var titleCard: UILabel!
    @IBOutlet var descriptionCard: UILabel!
    @IBOutlet var howManySold: UILabel!
    @IBOutlet var oldPrice: UILabel!
    @IBOutlet var newPrice: UILabel!
    @IBOutlet var Location: UILabel!
    @IBOutlet var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        detailImage.layer.cornerRadius = 8.0
    }
    
    public func setup(_ deal: Deal) {
        
        let oldPriceAttributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(format: "€ %.2f", deal.from))
        oldPriceAttributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, oldPriceAttributeString.length))
        
        detailImage.image = nil
        titleCard.text = deal.title
        descriptionCard.text = deal.company_name
        howManySold.text = deal.formattedSoldText
        Location.text =  deal.city_name
        oldPrice.attributedText = oldPriceAttributeString
        newPrice.text = String (format: "€ %.2f", deal.price)
    }
    
    public func updateImage(_ image: UIImage) {
        
        if detailImage.image == nil {
            detailImage.alpha = 0.0
        }
        
        detailImage.image = image
        
        UIView.animate(withDuration: 0.2) {
            self.detailImage.alpha = 1.0
        }
    }
}
