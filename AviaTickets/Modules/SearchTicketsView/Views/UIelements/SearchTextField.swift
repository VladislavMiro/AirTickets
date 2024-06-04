//
//  SearchTextField.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit
import Combine

final class SearchTextField: UITextField {
    
    //MARK: - Public properties
    
    public var leftViewImage: UIImage? = nil {
        didSet {
            setLeftViewImage(image: leftViewImage)
        }
    }
    
    //MARK: - UI elements
    
    private lazy var imageView: UIImageView = {
        let size = CGSize(width: Constants.leftViewSize, height: Constants.leftViewSize)
        let frame = CGRect(origin: .zero, size: size)
        let imageView = UIImageView(frame: frame)

        imageView.contentMode = .scaleAspectFit
   
        return imageView
    }()
    
    private lazy var rightClearButton: UIButton = {
        let size = CGSize(width: Constants.rightViewSize,
                          height: Constants.rightViewSize)
        let frame = CGRect(origin: .zero, size: size)
        let button = UIButton(frame: frame)
        
        button.setImage(Images.clearButton, for: .normal)
        
        return button
    }()
    
    //MARK: - Initialaizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with public methods

extension SearchTextField {
    
    public func addClearButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        rightClearButton.addTarget(target, action: action, for: controlEvents)
    }
    
}

//MARK: - Extension with private methods

private extension SearchTextField {
    
    func configuration() {
        font = Fonts.buttonText1
        textColor = Colors.text
        borderStyle = .none
        keyboardType = .default
        returnKeyType = .search
        keyboardAppearance = .dark
        
        let leftViewWidth = Constants.leftViewSize + Constants.leftViewPadding
        
        let leftViewSize = CGSize(width: leftViewWidth,
                                  height: Constants.leftViewSize)
        let leftViewFrame = CGRect(origin: .zero,
                                   size: leftViewSize)
        let lefView = UIView(frame: leftViewFrame)
        
        lefView.addSubview(imageView)
        
        self.leftView = lefView
        
        rightViewMode = .always
        rightView = rightClearButton
    }
    
    private func setLeftViewImage(image: UIImage?) {
        leftViewMode = image == nil ? .never : .always
        imageView.image = image
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchTextField {
    
    enum Colors {
        static let text = R.color.whiteTextColor()
    }
    
    enum Images {
        static let clearButton = R.image.close()
    }
    
    enum Constants {
        static let leftViewSize = 24.0
        static let leftViewPadding = 8.0
        static let rightViewSize = 24.0
        static let rightViewPadding = 8.0
    }
    
}
