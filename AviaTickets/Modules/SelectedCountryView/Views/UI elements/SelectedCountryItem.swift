//
//  SelectedCountryItem.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import UIKit

final class SelectedCountryItem: UICollectionViewCell {
    
    //MARK: - Public properties
    
    public static let identifire = StringConstants.identifire
    
    //MARK: - UI elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.title4
        label.textColor = Colors.label
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = Constants.hStackSpacing
        
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
    
}

//MARK: - Extension with public methods

extension SelectedCountryItem {
    
    public func setup(for type: SelectedCountryItemType, data: SelectedCountryItemData) {
        switch type {
        case .departureDate:
            setData(image: nil, data: data.departureDay)
        case .returningDay:
            if let data = data.returningDay {
                setData(image: nil, data: data)
            } else {
                setData(image: Images.returningDayItem,
                        data: StringConstants.returningDayPlaceholder)
            }
        case .ticketClass:
            setData(image: Images.ticketClassAndPersonNumberItem,
                    data: data.ticketClassAndPassangerNumber)
        case .filters:
            setData(image: Images.filterItem, data: StringConstants.filterTitle)
        }
    }
    
}

//MARK: - Extension with private methods

private extension SelectedCountryItem {
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.cornerRadius
        
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(label)
        
        contentView.addSubview(hStack)
    }
    
    func layout() {
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(Constants.imageViewSize)
            $0.width.equalTo(Constants.imageViewSize)
        }
        
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(Constants.horizontalOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.verticalOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.verticalOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.horizontalOffset)
        }
        
    }
    
    func setData(image: UIImage?, data: String) {
        imageView.image = image
        imageView.isHidden = image == nil
        label.text = data
    }
    
}

//MARK: - Extension with private subobjects

private extension SelectedCountryItem {
 
    enum Constants {
        static let hStackSpacing = 8.0
        static let cornerRadius = 15.0
        static let imageViewSize = 16.0
        static let verticalOffset = 10.0
        static let horizontalOffset = 8.0
    }
    
    enum Colors {
        static let label = R.color.whiteTextColor()
        static let background = R.color.grey3()
    }
    
    enum Images {
        static let returningDayItem = R.image.plus()
        static let ticketClassAndPersonNumberItem = R.image.human()
        static let filterItem = R.image.settings()
    }
    
    enum StringConstants {
        static let identifire = "SelectedCountryItem"
        static let filterTitle = "Фильтры"
        static let returningDayPlaceholder = "Обратно"
    }
    
}
