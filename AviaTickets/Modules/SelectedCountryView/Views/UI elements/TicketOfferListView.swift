//
//  TicketOfferListView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import UIKit

final class TicketOfferListView: UIView {
    
    //MARK: - UI elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title2
        label.textAlignment = .natural
        label.textColor = Colors.title
        label.text = StringConstants.title
        
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = Colors.separator
        tableView.separatorInset = .init(top: .zero,
                                         left: .zero,
                                         bottom: .zero,
                                         right: .zero)
        tableView.register(TicketOfferListCell.self,
                           forCellReuseIdentifier: TicketOfferListCell.indentifire)
        
        return tableView
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(StringConstants.showAllButtonTitle, for: .normal)
        button.titleLabel?.font = Fonts.text1
        button.setTitleColor(Colors.showAllButton, for: .normal)
        button.isHidden = true
        
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

//MARK: - Extension with public methods

extension TicketOfferListView {
    
    public func reloadTableView() {
        tableView.reloadData()
    }
    
}

//MARK: - Extension with private methods

private extension TicketOfferListView {
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    func layout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(Constants.verticalOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketOfferListView {
    
    enum Colors {
        static let title = R.color.whiteTextColor()
        static let background = R.color.grey1()
        static let separator = R.color.grey5()
        static let showAllButton = R.color.darkBlue()
    }
    
    enum Constants {
        static let cornerRadius = 16.0
        static let layoutOffset = 16.0
        static let verticalOffset = 8.0
    }
    
    enum StringConstants {
        static let title = "Прямые рельсы"
        static let showAllButtonTitle = "Показать все"
    }
    
}

