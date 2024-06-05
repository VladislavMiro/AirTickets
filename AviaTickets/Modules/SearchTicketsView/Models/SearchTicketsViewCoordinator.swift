//
//  SearchTicketsViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit

final class SearchTicketsViewCoordinator {
    
    //MARK: - Public properties
    
    public var childCoordinators: [Coordinator] = []
    
    //MARK: - Private properties
    
    private let navigationController: UINavigationController
    private weak var parentCoordinator: Coordinator?
    private let departureData: String
    private var currentViewController: UIViewController!
    
    //MARK: - Initialaizers
    
    public init(navigationController: UINavigationController, 
                parentCoordinator: Coordinator,
                data: String) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.departureData = data
    }
    
}

//MARK: - Extension with CoordinatorProtocol implementation

extension SearchTicketsViewCoordinator: Coordinator {
    
    public func start() {
        let factory = SearchTicketsViewModuleFactory(coordinator: self, data: departureData)
        let view = factory.createModule()
        
        view.modalPresentationStyle = .popover
        currentViewController = view
        
        navigationController.present(view, animated: true)
    }
    
}

//MARK: - Extension with SearchTicketsViewCoordinatorProtocol implementation

extension SearchTicketsViewCoordinator: SearchTicketsViewCoordinatorProtocol {
    
    public func showDificultDirrectionView() {
        showPlaceholderView()
    }
    
    public func showWeekendView() {
        showPlaceholderView()
    }
    
    public func showHotTicketsView() {
        showPlaceholderView()
    }
    
    
    public func showSelectedCountryView(arrivalData: String) {
        let coordinator = SelectedCountryViewCoordinator(
            navigationContorller: navigationController,
            parentCoordinator: self,
            departureData: departureData,
            arrivalData: arrivalData)
        
        currentViewController.dismiss(animated: true)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    public func didFinishView() {
        parentCoordinator?.finish(coordinator: self)
    }
    
}

//MARK: - Extension with private methods

private extension SearchTicketsViewCoordinator {
    
    func showPlaceholderView() {
        let coordinator = SearchPlaceholderViewCoordinator(
            navigationController: navigationController,
            parentCoordinator: self)
        
        currentViewController.dismiss(animated: true)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
}
