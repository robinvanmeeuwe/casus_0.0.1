//
//  DataLoader.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 29/10/2021.
//

import Foundation
import UIKit

public class DataLoader {
    
    func load(completionHandler: @escaping (DealList) -> Void) {
        
        let urlString = "https://media.socialdeal.nl/demo/deals.json"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            // parse json
            let decoder = JSONDecoder()
            
            do {
                let dealList = try decoder.decode(DealList.self, from: data)
                completionHandler(dealList)
            } catch {
                print("Error in JSON parsing: \(error.localizedDescription)")
            }
        }.resume()  
    }
    
    func downloadImage(urlString: String, indexPath: IndexPath, completionHandler: @escaping ((UIImage, IndexPath) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                completionHandler(image, indexPath)
            }
        }.resume()
    }
}
