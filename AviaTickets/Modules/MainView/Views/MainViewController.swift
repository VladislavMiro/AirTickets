//
//  MainViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

final class MainViewController: UITabBarController {
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

}

//MARK: - Extension with private methods

private extension MainViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
        tabBar.barTintColor = Colors.background
        tabBar.isTranslucent = false
        tabBar.tintColor = Colors.selcetedItemColor
        tabBar.unselectedItemTintColor = Colors.unselectedItemColor
        
        let borderSize = CGSize(width: view.bounds.width,
                                height: Constants.tabBarBorderHeight)
        let borderFrame = CGRect(origin: .zero, size: borderSize)
        let border = UIView(frame: borderFrame)
        
        border.backgroundColor = Colors.tabBarBorderColor
        
        tabBar.addSubview(border)
    }
    
}

//MARK: - Extension with private subobjects

private extension MainViewController {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
        static let tabBarBackground = R.color.backgroundBlackColor()
        static let tabBarBorderColor = R.color.grey1()
        static let selcetedItemColor = R.color.blueTintColor()
        static let unselectedItemColor = R.color.grey6()
    }
    
    enum Constants {
        static let tabBarBorderHeight: CGFloat = 1.0
    }
    
}

