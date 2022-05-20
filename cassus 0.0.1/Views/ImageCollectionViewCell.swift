//
//  ImageCollectionViewCell.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 18/11/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    
    func setup(imageURL: String) {
        imageView.downloaded(from: imageURL)
    }
}


