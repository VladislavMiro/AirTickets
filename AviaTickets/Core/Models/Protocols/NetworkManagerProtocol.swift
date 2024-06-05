//
//  NetworkManagerProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation
import Combine

protocol AirTicketsNetworkManagerProtocol {
    func fetchMusicTravelOffers() -> Future<AirTicketsNetworkResponse, Error>
}

protocol SelectedCountryNetworkManagerProtocol {
    func fetchTicketOffers() -> Future<SelectedCountryNetworkResponse, Error>
}
