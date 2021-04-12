//
//  Product.swift
//  motiv8ai
//
//  Created by Roman Sukner on 12/04/2021.
//


//   let product = try? newJSONDecoder().decode(Product.self, from: jsonData)

import Foundation

// MARK: - Product
class Product: Codable {
    let bagColor, name, weight: String
    
    init(bagColor: String, name: String, weight: String) {
        self.bagColor = bagColor
        self.name = name
        self.weight = weight
    }
}
