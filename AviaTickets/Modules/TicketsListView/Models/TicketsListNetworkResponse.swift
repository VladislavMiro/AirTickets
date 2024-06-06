//
//  TicketsListNetworkResponse.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation

struct TicketsListNetworkResponse: Decodable {
    let tickets: [Ticket]
}
