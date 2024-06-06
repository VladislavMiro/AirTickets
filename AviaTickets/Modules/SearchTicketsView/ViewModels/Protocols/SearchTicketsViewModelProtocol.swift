//
//  SearchTicketsViewModelProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation
import Combine

protocol SearchTicketsViewModelProtocol: AnyObject {
    
    var departure: String { get }
    var cities: [City] { get }
    var arrival: AnyPublisher<String, Never> { get } 
    
    func setArrival(data: String)
    func showSekectedCountryView()
    func buttonTapped(type: SearchViewButtonType)
    func selectRow(at index: Int)
    func didFinish()
}
