//
//  TicketOfferListCell.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import UIKit

final class TicketOfferListCell: UITableViewCell {
    
    //MARK: - Public properties
    
    public static let indentifire = StringConstants.identifire
    
    //MARK: - UI elements
    
    private lazy var ticketImageView: UIImageView = {
        let size = CGSize(width: Constants.imageSize,
                          height: Constants.imageSize)
        let frame = CGRect(origin: .zero, size: size)
        let imageView = UIImageView(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.titleLabel
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textAlignment = .natural
        label.textColor = Colors.priceLabel
        
        return label
    }()
    
    private lazy var detailArrowIcon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = Images.priceLabel
        
        return imageView
    }()
    
    private lazy var priceLabelStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        
        return stack
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.descriptionLabel
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = Constants.vStackSpacing
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    //MARK: - Initialaizers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with public methods

extension TicketOfferListCell {
    
    public func setup(image: Int, data: TicketOffersCellOutput) {
        titleLabel.text = data.title
        descriptionLabel.text = data.timeRange
        priceLabel.text = data.price
        
        switch image {
        case 0:
            ticketImageView.backgroundColor = Colors.firstCell
        case 1:
            ticketImageView.backgroundColor = Colors.secondCell
        case 2:
            ticketImageView.backgroundColor = Colors.thirdCell
        default:
            ticketImageView.backgroundColor = Colors.thirdCell
        }
    }
    
}

//MARK: - Extension with private methods

private extension TicketOfferListCell {
    
    func configuration() {
        backgroundColor = Colors.background
        
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(priceLabel)
        
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(ticketImageView)
        contentView.addSubview(vStack)
        contentView.addSubview(detailArrowIcon)
    }
    
    func layout() {
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.leading.equalToSuperview()
        }
        
        ticketImageView.snp.makeConstraints {
            $0.height.width.equalTo(Constants.imageSize)
        }
        
        detailArrowIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(Constants.detailArrowIcon)
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.leading.equalTo(ticketImageView.snp.trailing)
                .offset(Constants.layoutOffset)
            $0.trailing.equalTo(detailArrowIcon.snp.leading)
            $0.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketOfferListCell {
    
    enum Colors {
        static let background = R.color.grey1()
        static let titleLabel = R.color.whiteTextColor()
        static let descriptionLabel = R.color.whiteTextColor()
        static let priceLabel = R.color.darkBlue()
        static let firstCell = R.color.redTintColor()
        static let secondCell = R.color.blueTintColor()
        static let thirdCell = R.color.whiteTextColor()
    }
    
    enum Constants {
        static let imageSize = 24.0
        static let detailArrowIcon = 16.0
        static let layoutOffset = 8.0
        static let vStackSpacing = 4.0
    }
    
    enum Images {
        static let priceLabel = R.image.rightArrow()
    }
    
    enum StringConstants {
        static let identifire = "SelectedCountryTicketsListCell"
    }
    
}
