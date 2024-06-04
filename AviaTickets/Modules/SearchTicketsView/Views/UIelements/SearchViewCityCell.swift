//
//  SearchViewCityCell.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SearchViewCityCell: UITableViewCell {
    
    //MARK: - Public properties
    
    public static let indentifire = "SearchViewCityCell"
    
    //MARK: - UI elements
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title3
        label.textColor = Colors.nameLabel
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.descriptionLabel
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = Constants.vStackSpacing
        
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

extension SearchViewCityCell {
    
    public func setup(data: City) {
        image.image = UIImage(named: data.image)
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
    
}

//MARK: - Extension with private methods

private extension SearchViewCityCell {
    
    func configuration() {
        backgroundColor = .clear
        
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(image)
        contentView.addSubview(vStack)
    }
    
    func layout() {
        contentView.layoutMargins = .init(top: Constants.contentViewTopMargin,
                                          left: Constants.contentViewLeftMargin,
                                          bottom: Constants.contentViewBottomMargin,
                                          right: Constants.contentViewRightMargin)
        
        image.snp.makeConstraints {
            $0.height.width.equalTo(Constants.imageViewSize)
            $0.centerY.equalToSuperview()
            $0.leadingMargin.equalToSuperview()
        }
        
        vStack.snp.makeConstraints {
            $0.topMargin.equalToSuperview()
            $0.bottomMargin.equalToSuperview()
            $0.trailingMargin.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing)
                .offset(Constants.imageLabelsSpacing)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchViewCityCell {
    
    enum Constants {
        static let imageViewCornerRadius = 8.0
        static let imageViewSize = 40.0
        static let contentViewLeftMargin = 16.0
        static let contentViewRightMargin = -16.0
        static let contentViewTopMargin = 8.0
        static let contentViewBottomMargin = -8.0
        static let imageLabelsSpacing = 8.0
        static let vStackSpacing = 4.0
    }
    
    enum Colors {
        static let nameLabel = R.color.whiteTextColor()
        static let descriptionLabel = R.color.grey5()
    }
    
}
