//
//  SelectedCountryViewCoordinatorPorotocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation

protocol SelectedCountryViewCoordinatorPorotocol: AnyObject {
    
    func popView()
    func didFinish()
    func showTicketsListView(departureData: String, arrivalData: String,
                             departureDay: Date,  numberOfPassangers: Int)
    
}
