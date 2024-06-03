//
//  Offer.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation

struct Offer: Decodable {
    let id: Int
    let title: String
    let town: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, town, price
    }
    
    enum AdditionalPriceKey: String, CodingKey {
        case value
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.town = try container.decode(String.self, forKey: .town)
        
        let nestedContainer = try container.nestedContainer(keyedBy: AdditionalPriceKey.self, forKey: .price)
        
        self.price = try nestedContainer.decode(Int.self, forKey: .value)
    }
    
}
