//
//  Luggage.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation

struct Luggage: Decodable {
    let hasLuggage: Bool
    let price: Price?
}
