//
//  SearchPlaceholderViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SearchPlaceholderViewCoordinator {
    
    //MARK: - Public properties
    
    public var childCoordinators: [Coordinator] = []
    
    //MARK: - Private properties
    
    private let navigationController: UINavigationController
    private weak var parentCoordinator: Coordinator?
    
    //MARK: - Initialaizers
    
    public init(navigationController: UINavigationController, parentCoordinator: Coordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
}

//MARK: - Extension with CoordinatorProtocol implementation

extension SearchPlaceholderViewCoordinator: Coordinator {
    
    public func start() {
        let viewModel = SearchPlaceholderViewModel(coordinator: self)
        let view = SearchPlaceholderViewController(viewModel: viewModel)
        
        navigationController.pushViewController(view, animated: true)
    }
    
}

//MARK: - Extension with SearchPlaceholderViewCoordinatorProtocol implementation

extension SearchPlaceholderViewCoordinator: SearchPlaceholderViewCoordinatorProtocol {
    
    public func popView() {
        parentCoordinator?.finish(coordinator: self)
        navigationController.popViewController(animated: true)
    }
    
}
