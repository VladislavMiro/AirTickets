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
    
    private let viewModel: TicketsListViewModelProtocol
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - UI elements
    
    private lazy var navigationView: TicketsListNavigationView = {
        let view = TicketsListNavigationView()
        
        view.addTarget(self,
                       action: #selector(backButtonTapped),
                       for: .touchUpInside)
        
        return view
    }()
    
    //MARK: - Imitialaizers
    
    public init(viewModel: TicketsListViewModelProtocol) {
        self.viewModel = viewModel
        cancelable = []
        
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
        
        navigationView.set(title: viewModel.title,
                           subtitle: viewModel.subtitle)
        
        view.addSubview(navigationView)
    }
    
    func layout() {
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(Constants.layoutOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
    }
    
    func bind() {
        
    }
    
    @objc func backButtonTapped() {
        viewModel.popView()
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewController {
    
    enum Constants {
        static let layoutOffset = 16.0
    }
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
    }
    
}
