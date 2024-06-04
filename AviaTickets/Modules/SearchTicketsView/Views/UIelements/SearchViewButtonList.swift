//
//  SearchViewButtonList.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SearchViewButtonList: UIControl {
    
    //MARK: - Private properties
    
    private var buttons: [SearchViewButton] = []
    
    //MARK: - UI elements
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    //MARK: - Initialaizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overriden methods
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        
        buttons.forEach { button in
            button.addTarget(target, action: action, for: controlEvents)
        }
        
    }
    
}

//MARK: - Extension with private methods

private extension SearchViewButtonList {
    
    func configuration() {
        backgroundColor = .clear
        
        configureButtons()
        
        buttons.forEach { button in
            hStack.addArrangedSubview(button)
        }
        
        addSubview(hStack)
    }
    
    func layout() {
        
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttons.forEach { buttons in
            buttons.snp.makeConstraints {
                $0.height.equalTo(Constants.buttonHeight)
                $0.width.equalTo(Constants.buttonWidth)
            }
        }
        
    }
    
    func configureButtons() {
        buttons = [ 
            SearchViewButton(type: .dificultRoute,
                             label: StringConstants.dificultRouteButton,
                             image: Images.dificultRouteButton,
                             color: Colors.dificultRouteButton),
            SearchViewButton(type: .somewhere,
                             label: StringConstants.somewhereButton,
                             image: Images.somewhereButton,
                             color: Colors.somewhereButton),
            SearchViewButton(type: .weekend,
                             label: StringConstants.weekendButton,
                             image: Images.weekendButton,
                             color: Colors.weekendButton),
            SearchViewButton(type: .hotTickets,
                             label: StringConstants.hotTicketsButton,
                             image: Images.hotTicketsButton,
                             color: Colors.hotTicketsButton)
        ]
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchViewButtonList {
    
    enum Colors {
        static let dificultRouteButton = R.color.darkGreen()
        static let somewhereButton = R.color.blueTintColor()
        static let weekendButton = R.color.darkBlue()
        static let hotTicketsButton = R.color.redTintColor()
    }
    
    enum Images {
        static let dificultRouteButton = R.image.route()
        static let somewhereButton = R.image.earth()
        static let weekendButton = R.image.calendar()
        static let hotTicketsButton = R.image.fire()
    }
    
    enum StringConstants {
        static let dificultRouteButton = "Сложный маршрут"
        static let somewhereButton = "Куда угодно"
        static let weekendButton = "Выходные"
        static let hotTicketsButton = "Горячие билеты"
    }
    
    enum Constants {
        static let buttonHeight = 90.0
        static let buttonWidth = 80.0
    }
    
}
