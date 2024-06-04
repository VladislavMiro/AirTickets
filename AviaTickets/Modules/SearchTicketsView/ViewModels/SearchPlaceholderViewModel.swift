//
//  SearchPlaceholderViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation

final class SearchPlaceholderViewModel {
    
    //MARK: - Private properites
    
    private let coordinator: SearchPlaceholderViewCoordinatorProtocol
    
    //MARK: - Initialaizers
    
    public init(coordinator: SearchPlaceholderViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

//MARK: - Extension with SearchPlaceholderViewModelProtocol Implementation

extension SearchPlaceholderViewModel: SearchPlaceholderViewModelProtocol {
    
    public func popView() {
        coordinator.popView()
    }
    
}
