//
//  TicketsListViewModelProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation
import Combine

protocol TicketsListViewModelProtocol: AnyObject {
    
    var title: String { get }
    var subtitle: String { get }
    var tickets: [TicketOutput] { get }
    var state: AnyPublisher<TicketsListState, Never> { get }
    
    func fetchData()
    func popView()
    
}
