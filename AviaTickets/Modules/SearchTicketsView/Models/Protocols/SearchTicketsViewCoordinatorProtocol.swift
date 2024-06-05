//
//  SearchTicketsViewCoordinatorProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit

protocol SearchTicketsViewCoordinatorProtocol: AnyObject {

    func showSelectedCountryView(arrivalData: String)
    func showDificultDirrectionView()
    func showWeekendView()
    func showHotTicketsView()
    func didFinishView()
    
}
