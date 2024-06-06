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
    
    func popView()
    
}
