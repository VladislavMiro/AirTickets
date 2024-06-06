//
//  TicketsListBottomButtonView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketsListBottomButtonView: UIControl {
    
    //MARK: - UI elements
    
    private(set) lazy var filterButton: UIButton = {
        let button = UIButton()

        button.setTitleColor(Colors.button, for: .normal)
        button.setTitleColor(Colors.button?
            .withAlphaComponent(Constants.buttonColorAlpha),
                             for: .highlighted)
        button.setTitle(StringConstants.filterButton, for: .normal)
        button.setImage(Images.filterButton, for: .normal)
        button.titleLabel?.font = Fonts.title4
        
        return button
    }()
    
    private(set) lazy var priceGraphButton: UIButton = {
        let button = UIButton()

        button.setTitleColor(Colors.button, for: .normal)
        button.setTitleColor(Colors.button?
            .withAlphaComponent(Constants.buttonColorAlpha),
                             for: .highlighted)
        button.setTitle(StringConstants.priceGraphicsButton, for: .normal)
        button.setImage(Images.priceGraphicsButton, for: .normal)
        button.titleLabel?.font = Fonts.title4
        
        return button
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
    
}

//MARK: - Extension with private methods

private extension TicketsListBottomButtonView {
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(filterButton)
        addSubview(priceGraphButton)
    }
    
    func layout() {
        
        filterButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
                
        }
        
        priceGraphButton.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
            $0.leading.equalTo(filterButton.snp.trailing)
                .offset(Constants.buttonSpacing)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListBottomButtonView {
    
    enum Colors {
        static let button = R.color.whiteTextColor()
        static let background = R.color.darkBlue()
    }
    
    enum Constants {
        static let layoutOffset = 10.0
        static let buttonSpacing = 16.0
        static let buttonColorAlpha = 0.6
        static let cornerRadius = 20.0
    }
    
    enum Images {
        static let filterButton = R.image.settings()
        static let priceGraphicsButton = R.image.graph()
    }
    
    enum StringConstants {
        static let filterButton = "Фильтр"
        static let priceGraphicsButton = "График цен"
    }
    
}
