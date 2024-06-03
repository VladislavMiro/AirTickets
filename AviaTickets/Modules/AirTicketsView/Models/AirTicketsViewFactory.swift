//
//  AirTicketsModuleFactory.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit

final class AirTicketsModuleFactory {
    
    //MARK: - Private properties
    
    private let networkManager: AirTicketsNetworkManagerProtocol
    private let coordinator: AirTicketsViewCoordinatorProtocol
    //MARK: - Initialaziers
    
    public init(coordinator: AirTicketsViewCoordinatorProtocol) {
        self.coordinator = coordinator
        
        self.networkManager = NetworkManager()
    }
    
}

//MARK: - Extension with public methods

extension AirTicketsModuleFactory {
    
    public func createModule() -> UIViewController {
        let viewModel = AirTicketsViewModel(coordinator: coordinator,
                                            networkManager: networkManager)
        let view = AirTicketsViewController(viewModel: viewModel)
        
        return view
    }
    
}
