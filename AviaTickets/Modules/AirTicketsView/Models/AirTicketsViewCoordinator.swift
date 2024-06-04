//
//  AirTicketsViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

final class AirTicketsViewCoordinator {
    
    //MARK: - Public properties
    
    public var childCoordinators: [Coordinator] = []
    
    //MARK: - Private properties
    
    private let navigationCoontroller: UINavigationController
    
    //MARK: - Initialaizers
    
    public init(navigationCoontroller: UINavigationController) {
        self.navigationCoontroller = navigationCoontroller
    }
    
}

//MARK: - Extension with Coordinator protocol implementation

extension AirTicketsViewCoordinator: Coordinator {
    
    public func start() {
        let factory = AirTicketsModuleFactory(coordinator: self)
        let view = factory.createModule()
        
        navigationCoontroller.pushViewController(view, animated: false)
    }
    
}

//MARK: - Extension with AirTicketsViewCoordinatorProtocol implementation

extension AirTicketsViewCoordinator: AirTicketsViewCoordinatorProtocol {
    
    public func showSearchView(data: String) {
        let coordinator = SearchTicketsViewCoordinator(
            navigationController: navigationCoontroller,
            parentCoordinator: self,
            data: data)
        
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
}
