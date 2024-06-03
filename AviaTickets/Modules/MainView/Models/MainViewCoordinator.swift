//
//  MainViewCoordinator.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

final class MainViewCoordinator {
    
    //MARK: - Private properties
    
    private let window: UIWindow
    private let factory: MainViewModuleFactoryProtocol
    
    //MARK: - Initialaizers
    
    public init(window: UIWindow) {
        self.window = window
        factory = MainViewModuleFactory()
    }
}

//MARK: - Extension with Coordinator Protocol

extension MainViewCoordinator: Coordinator {
    
    public func start() {
        let mainView = factory.createModule()
        
        createTabs(tabController: mainView)
        
        window.rootViewController = mainView
        
        window.makeKeyAndVisible()
    }
    
}

//MARK: - Extension with private methods

private extension MainViewCoordinator {
    
    func createTabs(tabController: UITabBarController) {
        var tabs: [UIViewController] = []
        

        let tab1 = UINavigationController()
        let airTicketsView = AirTicketsViewCoordinator(navigationCoontroller: tab1)
        
        airTicketsView.start()
        tab1.tabBarItem = UITabBarItem(title: StringConstants.airTicketsTabTitle,
                                       image: Images.airTicketsTab,
                                       tag: 0)
        
        tabs.append(tab1)
        
        let tab2 = PlaceHolderViewController()
        
        
        tab2.labelText = StringConstants.hotelsTabTitle
        tab2.tabBarItem = UITabBarItem(title: StringConstants.hotelsTabTitle,
                                       image: Images.hotelsTab,
                                       tag: 1)
        
        tabs.append(tab2)
        
        let tab3 = PlaceHolderViewController()
        
        tab3.labelText = StringConstants.shorterTabTitle
        tab3.tabBarItem = UITabBarItem(title: StringConstants.shorterTabTitle,
                                       image: Images.shorterTab,
                                       tag: 2)
        
        tabs.append(tab3)
        
        let tab4 = PlaceHolderViewController()
        
        tab4.labelText = StringConstants.subscriptionsTabTitle
        tab4.tabBarItem = UITabBarItem(title: StringConstants.subscriptionsTabTitle,
                                       image: Images.subscriptionsTab,
                                       tag: 3)
        
        tabs.append(tab4)
        
        let tab5 = PlaceHolderViewController()

        tab5.labelText = StringConstants.profileTabTitle
        tab5.tabBarItem = UITabBarItem(title: StringConstants.profileTabTitle,
                                       image: Images.profileTab,
                                       tag: 4)
        
        tabs.append(tab5)
        
        tabController.setViewControllers(tabs, animated: false)
    }
    
}

//MARK: - Extension with private subobjects

private extension MainViewCoordinator {
    
    enum StringConstants {
        static let airTicketsTabTitle = "Авиабилеты"
        static let hotelsTabTitle = "Отели"
        static let shorterTabTitle = "Короче"
        static let subscriptionsTabTitle = "Подписки"
        static let profileTabTitle = "Профиль"
    }
    
    enum Images {
        static let airTicketsTab = R.image.plane()
        static let hotelsTab = R.image.bed()
        static let shorterTab = R.image.landmark()
        static let subscriptionsTab = R.image.bell()
        static let profileTab = R.image.profile()
    }
}

