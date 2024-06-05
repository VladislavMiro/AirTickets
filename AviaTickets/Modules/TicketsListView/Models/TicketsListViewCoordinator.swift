//
//  TicketsListViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketsListViewCoordinator {
    
    //MARK: - Public properties
    
    public var childCoordinators: [Coordinator]
    
    //MARK: - Private properties
    
    private let navigationController: UINavigationController
    private weak var parentCoordinator: Coordinator?
    private let departureData: String
    private let arrivalData: String
    
    //MARK: - Initialaizers
    
    public init(navigationController: UINavigationController, 
                parentCoordinator: Coordinator,
                departureData: String, arrivalData:String) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.departureData = departureData
        self.arrivalData = arrivalData
        
        childCoordinators = []
    }
    
}

//MARK: - Extension with Coordinator Protocol implementation

extension TicketsListViewCoordinator: Coordinator {
    
    public func start() {
        let factory = TicketsListViewModuleFactory(departureData: departureData,
                                                   arrivalData: arrivalData,
                                                   coordinator: self)
        let view = factory.createModule()
        
        navigationController.pushViewController(view, animated: true)
    }
    
}

//MARK: - Extension with TicketsListViewCoordinatorProtocol implementation

extension TicketsListViewCoordinator: TicketsListViewCoordinatorProtocol {
    
    public func popView() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.finish(coordinator: self)
    }
    
}
