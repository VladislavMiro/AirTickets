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
    private let departureDay: Date
    private let numberOfPassangers: Int
    
    //MARK: - Initialaizers
    
    public init(navigationController: UINavigationController, 
                parentCoordinator: Coordinator,
                departureData: String, arrivalData:String,
                departureDay: Date,  numberOfPassangers: Int) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.departureData = departureData
        self.arrivalData = arrivalData
        self.departureDay = departureDay
        self.numberOfPassangers = numberOfPassangers
        
        childCoordinators = []
    }
    
}

//MARK: - Extension with Coordinator Protocol implementation

extension TicketsListViewCoordinator: Coordinator {
    
    public func start() {
        let factory = TicketsListViewModuleFactory(departureData: departureData,
                                                   arrivalData: arrivalData,
                                                   departureDay: departureDay,
                                                   numberOfPassangers: numberOfPassangers,
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
