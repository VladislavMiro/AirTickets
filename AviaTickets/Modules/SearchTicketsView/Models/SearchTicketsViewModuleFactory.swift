//
//  SearchTicketsViewModuleFactory.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit

final class SearchTicketsViewModuleFactory {
    
    //MARK: - Private properties
    
    private let data: String
    private let coordinator: SearchTicketsViewCoordinatorProtocol
    
    //MARK: - Initialaizers
    
    public init(coordinator: SearchTicketsViewCoordinatorProtocol, data: String) {
        self.data = data
        self.coordinator = coordinator
    }
    
}

//MARK: - Extension with public methods

extension SearchTicketsViewModuleFactory {
    
    public func createModule() -> UIViewController {
        let viewModel = SearchTicketsViewModel(coordinator: coordinator, data: data)
        let view = SearchTicketsViewController(viewModel: viewModel)
        
        return view
    }
    
}
