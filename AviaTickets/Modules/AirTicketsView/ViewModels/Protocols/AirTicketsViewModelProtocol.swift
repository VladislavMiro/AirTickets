//
//  AirTicketsViewModelProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation
import Combine

protocol AirTicketsViewModelProtocol: AnyObject {
    var statePublisher: AnyPublisher<AirTicketsViewState, Never> { get }
    var departure: String { get set }
    var offers: [Offer] { get }
    
    func fetchData()
    func cachedInputData()
    func loadCachedData()
    func showSearchView()
}
