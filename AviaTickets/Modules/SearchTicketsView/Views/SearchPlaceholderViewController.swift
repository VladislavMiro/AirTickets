//
//  SearchPlaceholderViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SearchPlaceholderViewController: UIViewController {

    //MARK: - Private properties
    
    private let viewModel: SearchPlaceholderViewModel
    
    //MARK: - UI elements
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = Fonts.buttonText1
        button.tintColor = Colors.tintColor
        button.setTitle(StringConstants.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Initialaizers
    
    public init(viewModel: SearchPlaceholderViewModel) {
        self.viewModel = viewModel
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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didFinish()
    }

}

//MARK: - Extension with private methods

private extension SearchPlaceholderViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
        view.addSubview(backButton)
    }
    
    func layout() {
        
        backButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc func buttonTapped() {
        viewModel.popView()
    }
    
}

//MARK: - Extension with private subobject

private extension SearchPlaceholderViewController {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
        static let tintColor = R.color.whiteTextColor()
    }
    
    enum StringConstants {
        static let buttonTitle = "Назад"
    }
    
}
