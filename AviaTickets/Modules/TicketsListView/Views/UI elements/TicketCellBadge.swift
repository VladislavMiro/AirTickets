//
//  TicketCellBadge.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketCellBadge: UIView {
    
    //MARK: - Public properties
    
    public var titleText: String = .empty {
        didSet {
            label.text = titleText
        }
    }
    
    //MARK: - UI elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - initialaizers
    
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

private extension TicketCellBadge {
    
    func configuration() {
        backgroundColor = Colors.background
        
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(label)
    }
    
    func layout() {
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.verticalOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.horizontalOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.verticalOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketCellBadge {
    
    enum Colors {
        static let background = R.color.darkBlue()
        static let label = R.color.whiteTextColor()
    }
    
    enum Constants {
        static let cornerRadius = 10.0
        static let horizontalOffset = 10.0
        static let verticalOffset = 2.0
    }
    
}
