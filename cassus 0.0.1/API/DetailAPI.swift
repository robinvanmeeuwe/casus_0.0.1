//
//  DataLoaderDetail.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 09/11/2021.
//

import Foundation

public class DetailAPI {
    
    static func getDetails(for unique: String, completionHandler: @escaping (DealDetail) -> Void) {
        
        let urlString = "https://media.socialdeal.nl/demo/details.json?id=\(unique)"
        print(urlString)
        
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
                let detailviewJSON = try decoder.decode(DealDetail.self, from: data)
                DispatchQueue.main.async {completionHandler(detailviewJSON)}
            } catch {
                print("Error in JSON parsing: \(error.localizedDescription)")
            }
        
            }.resume()
        }
    }
