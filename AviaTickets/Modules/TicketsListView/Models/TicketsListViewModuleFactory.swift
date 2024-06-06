//
//  TicketsListViewModuleFactory.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketsListViewModuleFactory {
    
    //MARK: - Private properties
    
    private let departureData: String
    private let arrivalData: String
    private let departureDay: Date
    private let numberOfPassangers: Int
    private let coordinator: TicketsListViewCoordinatorProtocol
    private let networkManager: TicketsListNetworkManagerProtocol
    
    //MARK: - Initialaizers
    
    public init(departureData: String, arrivalData: String,
                departureDay: Date,  numberOfPassangers: Int,
                coordinator: TicketsListViewCoordinatorProtocol) {
        self.departureData = departureData
        self.arrivalData = arrivalData
        self.departureDay = departureDay
        self.numberOfPassangers = numberOfPassangers
        self.coordinator = coordinator
        
        networkManager = NetworkManager()
    }
    
}

//MARK: - Extension with public methods

extension TicketsListViewModuleFactory {
    
    public func createModule() -> UIViewController {
        let viewModel = TicketsListViewModel(departue: departureData,
                                             arrival: arrivalData,
                                             departureDay: departureDay,
                                             numberOfPassangers: numberOfPassangers,
                                             coordinator: coordinator,
                                             networkManager: networkManager)
        let view = TicketsListViewController(viewModel: viewModel)
        
        return view
    }
    
}
