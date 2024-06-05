//
//  SelectedCountryViewModuleFactory.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SelectedCountryViewModuleFactory {
    
    //MARK: - Private properties
    
    private let departureData: String
    private let arrivalData: String
    private let coordinator: SelectedCountryViewCoordinatorPorotocol
    private let networkManager: SelectedCountryNetworkManagerProtocol
    
    //MARK: - Initialaizers
    
    public init(departureData: String, 
                arrivalData: String,
                coordinator: SelectedCountryViewCoordinatorPorotocol) {
        self.departureData = departureData
        self.arrivalData = arrivalData
        self.coordinator = coordinator
        
        networkManager = NetworkManager()
    }
    
    
}

//MARK: - Extension with public methods

extension SelectedCountryViewModuleFactory {
    
    public func buiildModule() -> UIViewController {
        let viewModel = SelectedCountryViewModel(arrivalData: arrivalData,
                                                 departureData: departureData,
                                                 coordinator: coordinator,
                                                 networkManager: networkManager)
        let view = SelectedCountryViewController(viewModel: viewModel)
        
        return view
    }
    
}
