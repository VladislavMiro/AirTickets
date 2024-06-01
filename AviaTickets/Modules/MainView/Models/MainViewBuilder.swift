//
//  MainViewModuleBuilder.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

final class MainViewModuleFactory {
    
}

//MARK: - Extension with MainViewModuleFactoryProtocol implementation

extension MainViewModuleFactory: MainViewModuleFactoryProtocol {
    
    public func createModule() -> UITabBarController {
        let view = MainViewController()
        return view
    }
    
}
