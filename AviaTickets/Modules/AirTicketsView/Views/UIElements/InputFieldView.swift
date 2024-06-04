//
//  InputFieldView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import UIKit
import Combine

final class InputFieldView: UIView {
    
    //MARK: - Private properties
    
    private var cancelable = Set<AnyCancellable>()
    
    //MARK: - UI elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.searchImage
        
        return imageView
    }()
    
    private(set) lazy var departureTextField: UITextField = {
        let textField = UITextField()
        let atributedString = NSAttributedString(string: StringConstants.departureTextField,
                                                 attributes: [.font : Fonts.buttonText1,
                                                              .foregroundColor : Colors.placeholderTextField ?? .lightGray])
        
        textField.borderStyle = .none
        textField.autocorrectionType = .yes
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.keyboardAppearance = .dark
        textField.textColor = Colors.textTextField
        textField.font = Fonts.buttonText1
        textField.attributedPlaceholder = atributedString
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.separator
        
        return view
    }()
    
    private(set) lazy var arrivalTextField: UITextField = {
        let textField = UITextField()
        let atributedString = NSAttributedString(string: StringConstants.arrivalTextField,
                                                 attributes: [.font : Fonts.buttonText1,
                                                              .foregroundColor : Colors.placeholderTextField ?? .lightGray])
        
        textField.borderStyle = .none
        textField.autocorrectionType = .yes
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.keyboardAppearance = .dark
        textField.autocapitalizationType = .sentences
        textField.font = Fonts.buttonText1
        textField.textColor = Colors.textTextField
        textField.attributedPlaceholder = atributedString
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = Constants.vStackSpacing
        
        return stackView
    }()
    
    private lazy var secondView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.secondBackgound
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = Colors.shadow
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowOffset = CGSize(width: Constants.shadowOffserWidth,
                                         height: Constants.shadowOffsetHeight)
        view.layer.shadowRadius = Constants.shadowRadius
        
        return view
    }()
    
    //MARK: - Initialaizers
    
    public init() {
        super.init(frame: .zero)
        configuration()
        layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with UITextFieldDelegate implementation

extension InputFieldView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        
        let predicate = NSPredicate(format: StringConstants.regexFormat,
                                    StringConstants.cyrilicRegex)
        
        return predicate.evaluate(with: string)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == arrivalTextField {
            departureTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        return true
    }
    
}

//MARK: - Extension with private methods

private extension InputFieldView {
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        
        vStackView.addArrangedSubview(departureTextField)
        vStackView.addArrangedSubview(separator)
        vStackView.addArrangedSubview(arrivalTextField)
        
        secondView.addSubview(imageView)
        secondView.addSubview(vStackView)
        
        addSubview(secondView)
    }
    
    func layout() {
        
        separator.snp.makeConstraints {
            $0.height.equalTo(Constants.separatorHeight)
            $0.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.height.width.equalTo(Constants.imageViewSize)
            $0.centerY.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing)
                .offset(Constants.layoutOffset)
            $0.top.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
            $0.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
        secondView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.bottom.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension InputFieldView {
    
    enum Constants {
        static let cornerRadius = 16.0
        static let vStackSpacing = 8.0
        static let searchImage = R.image.search()
        static let imageViewSize = 24
        static let separatorHeight = 1.0
        static let layoutOffset = 16.0
        static let shadowOpacity: Float = 0.5
        static let shadowRadius = 3.0
        static let shadowOffsetHeight = 3.0
        static let shadowOffserWidth = 0.0
    }
    
    enum Colors {
        static let background = R.color.grey3()
        static let secondBackgound = R.color.grey4()
        static let textTextField = R.color.whiteTextColor()
        static let separator = R.color.grey6()
        static let placeholderTextField = R.color.grey6()
        static let shadow = R.color.backgroundBlackColor()?.cgColor
    }
    
    enum StringConstants {
        static let departureTextField = "Откуда - Москва"
        static let arrivalTextField = "Куда - Турция"
        static let cyrilicRegex = "^[а-яА-ЯЁё\\.\\-]+$"
        static let regexFormat = "SELF MATCHES %@"
    }
    
}
