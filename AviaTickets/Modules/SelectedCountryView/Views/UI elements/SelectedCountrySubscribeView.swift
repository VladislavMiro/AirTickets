//
//  SelectedCountrySubscribeView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import UIKit

final class SelectedCountrySubscribeView: UIView {
    
    //MARK: - UI elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.imageView
        imageView.image = Images.imageView?
            .withRenderingMode(.alwaysTemplate)
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text1
        label.textColor = Colors.title
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.text = StringConstants.title
        
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Constants.hStackSpacing
        
        return stack
    }()
    
    private(set) lazy var subscribeSwitch: UISwitch = {
        let subscribeSwitch = UISwitch()
        
        subscribeSwitch.onTintColor = Colors.swithOnTintColor
        subscribeSwitch.thumbTintColor = Colors.switchThumbColor
        subscribeSwitch.tintColor = Colors.switchTintColor
        
        return subscribeSwitch
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

private extension SelectedCountrySubscribeView {
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.viewCornerRadius
        
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(label)
        
        addSubview(hStack)
        addSubview(subscribeSwitch)
    }
    
    func layout() {
        
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.verticalOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.hStackLeadingOffset)
            $0.trailing.equalTo(subscribeSwitch.snp.leading)
            $0.bottom.equalToSuperview()
                .inset(Constants.verticalOffset)
        }
        
        subscribeSwitch.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.verticalOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.verticalOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.switchTrailingOffset)
            $0.centerY.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension SelectedCountrySubscribeView {
    
    enum Colors {
        static let title = R.color.whiteTextColor()
        static let imageView = R.color.darkBlue()
        static let switchTintColor = R.color.grey6()
        static let switchThumbColor = R.color.whiteTextColor()
        static let swithOnTintColor = R.color.darkBlue()
        static let background = R.color.grey2()
    }
    
    enum Images {
        static let imageView = R.image.bell()
    }
    
    enum Constants {
        static let hStackLeadingOffset = 16.0
        static let verticalOffset = 13.0
        static let switchTrailingOffset = 8.0
        static let viewCornerRadius = 8.0
        static let hStackSpacing = 8.0
    }
    
    enum StringConstants {
        static let title = "Подписка на цену"
    }
}
