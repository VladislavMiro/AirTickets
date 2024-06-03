//
//  AirTicketsNetworkResponse.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation

struct AirTicketsNetworkResponse: Decodable {
    let offers: [Offer]
}
