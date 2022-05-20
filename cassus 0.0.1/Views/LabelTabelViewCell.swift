//
//  LabelTabelViewCell.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 18/11/2021.
//

import Foundation
import UIKit

class LabelTabelViewCell: UITableViewCell {
    
    @IBOutlet var location1Detail: UILabel!
    @IBOutlet var location2Detail: UILabel!
    @IBOutlet var location3Detail: UILabel!
    
    func setup(_ location: DealDetail.Location) {
        
        location1Detail.text = location.cityName
        location2Detail.text = location.street
        location3Detail.text = "Routebeschrijving"
    }
}
