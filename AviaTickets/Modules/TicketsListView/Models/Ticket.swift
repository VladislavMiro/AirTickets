//
//  Ticket.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation

struct Ticket: Decodable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName: String
    let company: String
    let departure: Arrival
    let arrival: Arrival
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable: Bool
    let isExchangable: Bool
}
