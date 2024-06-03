//
//  AirTicketsSectionHeader.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import UIKit

final class AirTicketsSectionHeader: UIView {
    
    //MARK: - Public properties
    
    public var title: String = .empty {
        didSet {
            label.text = title
        }
    }
    
    //MARK: - UI elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title1
        label.textColor = .white
        label.textAlignment = .natural
        
        return label
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

private extension AirTicketsSectionHeader {
    
    func configuration() {
        backgroundColor = Colors.background
        addSubview(label)
    }
    
    func layout() {
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.horizontalOffset)
            $0.top.equalToSuperview()
                .offset(Constants.topOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.bottomOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsSectionHeader {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
    }
    
    enum Constants {
        static let horizontalOffset = 16.0
        static let bottomOffset = 26.0
        static let topOffset = 32.0
    }
    
}
