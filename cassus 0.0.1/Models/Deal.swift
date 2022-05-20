//
//  JsonData.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 26/10/2021.
//

import Foundation

struct Deal: Codable {
    let unique: String?
    let name: String?
    let title: String
    let slug: String?
    let city_slug: String?
    let company_slug: String?
    let city_name: String?
    let company_name: String
    let img: String
    let position: Int?
    let category: Int?
    let distance: Int?
    let location: String
    let single_location: String?
    let sold: Int
    let sold_text: String?
    let max: Float?
    let price: Float
    let from: Float
    let saved: Int?
    let start: String?
    let is_for_sale: Bool?
    let is_multi_deal: Bool?
    let is_donation_deal: Bool?
    let is_featured: Bool?
    let is_new_today: Bool?
    let city_lat: Float?
    let city_long: Float?
    
    var formattedSoldText: String {
        "Verkocht: \(sold)"
    }
    var imageURL: String {
        "https://media.socialdeal.nl\(img)"
    }
}

struct DealList: Codable {
    let deals: [Deal]
}
