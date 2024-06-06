//
//  NetworkManagerProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation
import Combine

protocol AirTicketsNetworkManagerProtocol: AnyObject {
    func fetchMusicTravelOffers() -> Future<AirTicketsNetworkResponse, Error>
}

protocol SelectedCountryNetworkManagerProtocol: AnyObject {
    func fetchTicketOffers() -> Future<SelectedCountryNetworkResponse, Error>
}

protocol TicketsListNetworkManagerProtocol: AnyObject {
    func fetchAllTickets() -> Future<TicketsListNetworkResponse, Error>
}
