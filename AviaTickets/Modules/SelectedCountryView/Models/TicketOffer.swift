//
//  Ticket.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import Foundation

struct TicketOffer: Decodable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case timeRange
        case price
    }
    
    enum PriceCodingKeys: String, CodingKey {
        case value
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.timeRange = try container.decode([String].self, forKey: .timeRange)
        
        let priceContainer = try container.nestedContainer(keyedBy: PriceCodingKeys.self, 
                                                           forKey: .price)
        
        self.price = try priceContainer.decode(Int.self, forKey: .value)
    }
    
}
