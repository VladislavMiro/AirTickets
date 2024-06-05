//
//  SelectedCountryViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SelectedCountryViewCoordinator {
    
    //MARK: - Public properties
    
    public var childCoordinators: [Coordinator] = []
    
    //MARK: - Private property
    
    private let navigationContorller: UINavigationController
    private let parentCoordinator: Coordinator?
    private let departureData: String
    private let arrivalData: String
    
    //MARK: - Initialaizers
    
    public init(navigationContorller: UINavigationController, 
                parentCoordinator: Coordinator,
                departureData: String,
                arrivalData: String) {
        self.navigationContorller = navigationContorller
        self.parentCoordinator = parentCoordinator
        self.departureData = departureData
        self.arrivalData = arrivalData
    }
    
}

//MARK: - Extension with CoordinatorProtocol implementation

extension SelectedCountryViewCoordinator: Coordinator {
    
    public func start() {
        let factory = SelectedCountryViewModuleFactory(departureData: departureData,
                                                       arrivalData: arrivalData,
                                                       coordinator: self)
        let view = factory.buiildModule()
        
        navigationContorller.pushViewController(view, animated: true)
    }
    
}

//MARK: - Extension with SelectedCountryViewCoordinatorProtocol implementation

extension SelectedCountryViewCoordinator: SelectedCountryViewCoordinatorPorotocol {
    
    public func popView() {
        navigationContorller.popViewController(animated: true)
        parentCoordinator?.finish(coordinator: self)
    }
    
}
