//
//  AirTicketsMusicCell.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import UIKit

final class AirTicketsMusicCell: UICollectionViewCell {
    
    //MARK: - UI elements
    
    private lazy var coverView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.coverViewCornerRadius
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title3
        label.textColor = Colors.label
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var directionLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.planeIcon
        
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.label
        label.textAlignment = .natural
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = .zero
        
        return stack
    }()
    
    //MARK: - Public properties
    
    public static let identifire = "AirTicketsMusicCell"
    
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

extension AirTicketsMusicCell {
    
    public func setup(data: AirTicketsMusicOffersOutput) {
        coverView.image = UIImage(named: data.image)
        nameLabel.text = data.title
        directionLabel.text = data.town
        priceLabel.text = data.price
    }
    
}

//MARK: - Extension with private methods

private extension AirTicketsMusicCell {
    
    func configuration() {
        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(priceLabel)
        
        contentView.addSubview(coverView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(directionLabel)
        contentView.addSubview(hStack)
    }
    
    func layout() {
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.coverViewHeight)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(coverView.snp.bottom)
                .offset(Constants.labelsOffset)
            $0.leading.trailing.equalTo(coverView)
        }
        
        directionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
                .offset(Constants.labelsOffset)
            $0.leading.trailing.equalTo(coverView)
        }
        
        iconView.snp.makeConstraints {
            $0.height.width.equalTo(Constants.planeIconSize)
        }
        
        hStack.snp.makeConstraints {
            $0.top.equalTo(directionLabel.snp.bottom)
                .offset(Constants.hStackOffset)
            $0.leading.trailing.equalTo(coverView)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsMusicCell {
    
    enum Constants {
        static let coverViewCornerRadius = 16.0
        static let coverViewHeight = 132.0
        static let labelsOffset = 8.0
        static let hStackOffset = 4.0
        static let planeIconSize = 24.0
        static let planeIcon = R.image.plane()
    }
    
    enum Colors {
        static let label = R.color.whiteTextColor()
    }
    
}
