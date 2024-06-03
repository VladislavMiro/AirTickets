//
//  AirTicketsHeader.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import UIKit
import Combine

final class AirTicketsHeader: UIView {
    
    //MARK: - Public properties
    
    public var departureTextField: UITextField {
        inputFiledView.departureTextField
    }
    
    public var arivalTextField: UITextField {
        inputFiledView.arrivalTextField
    }
    
    //MARK: - UI elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title1
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = Colors.textColor
        label.text = "Поиск дешевых \n авиабилетов"
        
        return label
    }()
    
    
    private lazy var inputFiledView: InputFieldView = {
        let view = InputFieldView()
        
        return view
    }()
    
    //MARK: - Initialaizers
    
    public init() {
        super.init(frame: .zero)
        configuration()
        layout()
    }
    
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

private extension AirTicketsHeader {
    
    func configuration() {
        addSubview(titleLabel)
        addSubview(inputFiledView)
    }
    
    func layout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.titleLabelTopOffset)
            $0.leading.trailing.equalToSuperview()
        }
        
        inputFiledView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(Constants.inputFieldViewTopOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.horizontalOffset)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsHeader {
    
    enum Constants {
        static let inputFieldViewTopOffset = 38.0
        static let titleLabelTopOffset = 26.0
        static let horizontalOffset = 16.0
    }
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
        static let textColor = R.color.whiteTextColor()
    }
    
}
