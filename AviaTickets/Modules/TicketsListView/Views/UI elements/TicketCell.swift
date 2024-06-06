//
//  TicketCell.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit

final class TicketCell: UICollectionViewCell {
    
    //MARK: - Public properties
    
    public static let identifire = StringConstants.identifire
    
    //MARK: - UI elements
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title1
        label.textColor = Colors.label
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var image: UIImageView = {
        let size = CGSize(width: Constants.imageSize,
                          height: Constants.imageSize)
        let frame = CGRect(origin: .zero, size: size)
        let view = UIImageView(frame: frame)
        
        view.backgroundColor = Colors.image
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = view.bounds.height / 2
        
        return view
    }()
    
    private lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var departureAirportCodeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.description
        label.textAlignment = .natural
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var dashView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.description
        
        return view
    }()
    
    private lazy var departureStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = Constants.stackSpacing
        
        return stack
    }()
    
    private lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var arrivalAirportCodeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.description
        label.textAlignment = .natural
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var arrivalStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = Constants.stackSpacing
        
        return stack
    }()
    
    private lazy var spentTimeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var slashLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.description
        label.textAlignment = .natural
        label.text = .slash
        
        return label
    }()
    
    private lazy var transferLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.text = StringConstants.transferLabel
        
        return label
    }()
    
    private lazy var badge: TicketCellBadge = {
        let view = TicketCellBadge()
        
        return view
    }()
    
    private lazy var backgroundLayer: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.background
        view.layer.cornerRadius = Constants.cornerRadius
        
        return view
    }()

    
    //MARK: - Initialaizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with public methods

extension TicketCell {
    
    public func setup(data: TicketOutput) {
        priceLabel.text = data.price
        departureTimeLabel.text = data.departureTime
        departureAirportCodeLabel.text = data.departureAirportCode
        arrivalTimeLabel.text = data.arrivalTime
        arrivalAirportCodeLabel.text = data.arrivalAirportCode
        spentTimeLabel.text = String(format: StringConstants.spentTimelabelFormat,
                                     data.spentTime)
        slashLabel.isHidden = !data.hasTransfer
        transferLabel.isHidden = !data.hasTransfer
        
        
         if let badge = data.badge {
             self.badge.isHidden = false
             self.badge.titleText = badge
             layoutIfNeeded()
         } else {
             badge.isHidden = true
             layoutIfNeeded()
         }
    }
    
}

//MARK: - Extension with private methods

private extension TicketCell {
    
    func configure() {
        departureStack.addArrangedSubview(departureTimeLabel)
        departureStack.addArrangedSubview(departureAirportCodeLabel)
        
        arrivalStack.addArrangedSubview(arrivalTimeLabel)
        arrivalStack.addArrangedSubview(arrivalAirportCodeLabel)
        backgroundLayer.addSubview(priceLabel)
        backgroundLayer.addSubview(image)
        backgroundLayer.addSubview(departureStack)
        backgroundLayer.addSubview(dashView)
        backgroundLayer.addSubview(arrivalStack)
        backgroundLayer.addSubview(spentTimeLabel)
        backgroundLayer.addSubview(slashLabel)
        backgroundLayer.addSubview(transferLabel)
        
        contentView.addSubview(backgroundLayer)
        contentView.addSubview(badge)
    }
    
    func layout() {
        
        priceLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
        }
        
        image.snp.makeConstraints {
            $0.width.height.equalTo(Constants.imageSize)
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.centerY.equalTo(departureStack.snp.centerY)
        }
        
        departureStack.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom)
                .offset(Constants.layoutOffset)
            $0.leading.equalTo(image.snp.trailing)
                .offset(Constants.imageTrailingOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.bottomOffset)
        }
        
        dashView.snp.makeConstraints {
            $0.leading.equalTo(departureStack.snp.trailing)
                .offset(Constants.dashOffset)
            $0.centerY.equalTo(departureTimeLabel.snp.centerY)
            $0.width.equalTo(Constants.dashViewWidth)
            $0.height.equalTo(Constants.dashViewHeight)
        }
        
        arrivalStack.snp.makeConstraints {
            $0.top.equalTo(departureStack.snp.top)
            $0.leading.equalTo(dashView.snp.trailing)
                .offset(Constants.dashOffset)
            $0.bottom.equalTo(departureStack.snp.bottom)
        }
        
        spentTimeLabel.snp.makeConstraints {
            $0.top.equalTo(departureStack.snp.top)
            $0.leading.equalTo(arrivalStack.snp.trailing)
                .offset(Constants.layoutOffset)
        }
        
        slashLabel.snp.makeConstraints {
            $0.top.equalTo(departureStack.snp.top)
            $0.leading.equalTo(spentTimeLabel.snp.trailing)
                .offset(Constants.trailingOffset)
            $0.trailing.equalToSuperview()
        }
        
        transferLabel.snp.makeConstraints {
            $0.top.equalTo(departureStack.snp.top)
            $0.leading.equalTo(slashLabel)
                .offset(Constants.transferLabelLeadingOffset)
           $0.trailing.equalToSuperview()
                .inset(Constants.trailingOffset)
        }
        
        backgroundLayer.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }

        badge.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(backgroundLayer.snp.top)

        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketCell {
    
    enum Colors {
        static let label = R.color.whiteTextColor()
        static let description = R.color.grey6()
        static let background = R.color.grey1()
        static let image = UIColor.red
    }
    
    enum Constants {
        static let cornerRadius = 8.0
        static let layoutOffset = 16.0
        static let trailingOffset = 4.0
        static let imageSize = 24.0
        static let dashViewHeight = 1.0
        static let dashViewWidth = 10.0
        static let dashOffset = 4.0
        static let bottomOffset = 23.0
        static let imageTrailingOffset = 8.0
        static let stackSpacing = 4.0
        static let transferLabelLeadingOffset = 8.0
    }
    
    enum StringConstants {
        static let identifire = "TicketCell"
        static let transferLabel = "Без пересадок"
        static let spentTimelabelFormat = "%@ч в пути"
    }
    
}
