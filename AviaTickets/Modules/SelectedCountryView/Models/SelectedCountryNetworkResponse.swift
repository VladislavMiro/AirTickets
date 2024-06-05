//
//  SelectedCountryNetworkResponse.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import Foundation

struct SelectedCountryNetworkResponse: Decodable {
    let ticketsOffers: [Ticket]
}
