//
//  TicketsListViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit
import Combine

final class TicketsListViewController: UIViewController {

    //MARK: - Private properties
    
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - UI elements
    
    //MARK: - Imitialaizers
    
    public init() {
        self.cancelable = []
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

//MARK: - Extension with private methods

private extension TicketsListViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
    }
    
    func layout() {
        
    }
    
    func bind() {
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewController {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
    }
    
}
