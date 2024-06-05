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
    private let coordinator: TicketsListViewCoordinatorProtocol
    
    //MARK: - Initialaizers
    
    public init(departureData: String, arrivalData: String, coordinator: TicketsListViewCoordinatorProtocol) {
        self.departureData = departureData
        self.arrivalData = arrivalData
        self.coordinator = coordinator
    }
    
}

//MARK: - Extension with public methods

extension TicketsListViewModuleFactory {
    
    public func createModule() -> UIViewController {
        let view = TicketsListViewController()
        
        return view
    }
    
}
