//
//  SelectedCountryViewModelProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation
import Combine

protocol SelectedCountryViewModelProtocol: AnyObject {
    
    var departure: AnyPublisher<String, Never> { get }
    var arrival: AnyPublisher<String, Never> { get }
    var isUpdateItemsView: AnyPublisher<Void, Never> { get }
    var isNetworkError: AnyPublisher<String, Never> { get }
    var sibscribeOnThePrice: AnyPublisher<Bool, Never> { get }
    var ticketOffersDowloadedPublisher: AnyPublisher<Void, Never> { get }
    var ticketOffers: [TicketOffersCellOutput] { get }
    var itemData: SelectedCountryItemData { get }
    
    func fetchData()
    func replaceData()
    func setArrival(data: String)
    func setDate(type:  SelectedCountryItemType, data: Date)
    func subscribeOnThePrice(data: Bool)
    func showAllTicketsView()
    func popView()
    
}
