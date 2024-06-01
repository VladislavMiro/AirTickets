//
//  MainViewModuleFactoryProtocol.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

protocol MainViewModuleFactoryProtocol: AnyObject {
    func createModule() -> UITabBarController
}
