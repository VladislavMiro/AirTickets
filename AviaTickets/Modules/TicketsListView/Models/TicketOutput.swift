//
//  TicketOutput.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation

struct TicketOutput {
    let badge: String?
    let price: String
    let departureTime: String
    let departureAirportCode: String
    let arrivalTime: String
    let arrivalAirportCode: String
    let spentTime: String
    let hasTransfer: Bool
}
