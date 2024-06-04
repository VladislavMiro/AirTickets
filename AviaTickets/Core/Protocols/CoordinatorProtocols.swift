//
//  CoordinatorProtocols.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    
}

//MARK: - Extension with default methods

extension Coordinator {
    
    func finish(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
}
