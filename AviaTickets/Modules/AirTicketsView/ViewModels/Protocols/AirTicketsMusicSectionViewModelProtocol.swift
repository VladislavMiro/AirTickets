//
//  AirTicketsMusicSectionViewModelProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation

protocol AirTicketsMusicSectionViewModelProtocol: AnyObject {
    var outputData: [AirTicketsMusicOffersOutput] { get }
    
    func prepareData()
}
