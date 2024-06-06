//
//  TicketsListNavigationView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketsListNavigationView: UIControl {
    
    //MARK: - UI elements
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Images.backButton?.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.tintColor = Colors.backButton
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title3
        label.textColor = Colors.title
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.subTitle
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = Constants.vStackSpacing
        
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
    
    //MARK: - Overrided methods
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        backButton.addTarget(target, action: action, for: controlEvents)
    }
    
}

//MARK: - Extension with public methods

extension TicketsListNavigationView {
    
    public func set(title: String, subtitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
    
}

//MARK: - Extension with private methods

private extension TicketsListNavigationView {
    
    func configuration() {
        backgroundColor = Colors.background
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subTitleLabel)
        
        addSubview(backButton)
        addSubview(vStack)
    }
    
    func layout() {
        
        backButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.backButtonSize)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.vStackOffset)
            $0.leading.equalTo(backButton.snp.trailing)
                .offset(Constants.vStackOffset)
            $0.bottom.trailing.equalToSuperview()
                .inset(Constants.vStackOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListNavigationView {
    
    enum Constants {
        static let vStackSpacing = 4.0
        static let backButtonSize = 24.0
        static let vStackOffset = 8.0
    }
    
    enum Colors {
        static let title = R.color.whiteTextColor()
        static let subTitle = R.color.grey6()
        static let background = R.color.grey2()
        static let backButton = R.color.darkBlue()
    }
    
    enum Images {
        static let backButton = R.image.leftArrow()
    }
    
}

