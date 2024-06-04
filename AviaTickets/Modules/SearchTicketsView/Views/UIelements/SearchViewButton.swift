//
//  SearchViewButton.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SearchViewButton: UIControl {
    
    //MARK: - Public properties

    public let type: SearchViewButtonType
    
    //MARK: - UI elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.contentMode = .center
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.text2
        label.textColor = Colors.text
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - Initialaizers
    
    public init(type: SearchViewButtonType, label: String, image: UIImage?, color: UIColor?) {
        self.type = type
        
        super.init(frame: .zero)
        
        self.label.text = label
        
        imageView.image = image
        imageView.backgroundColor = color
        
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with private methods

private extension SearchViewButton {
    
    func configuration() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(label)
    }
    
    func layout() {
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(Constants.imageViewSize)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
                .offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchViewButton {
    
    enum Constants {
        static let imageViewSize = 48.0
        static let imageViewCornerRadius = 8.0
        static let spacing = 8.0
    }
    
    enum Colors {
        static let text = R.color.whiteTextColor()
    }
    
}
