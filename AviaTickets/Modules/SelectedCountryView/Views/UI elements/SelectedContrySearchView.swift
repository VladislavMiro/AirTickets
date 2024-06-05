//
//  SelectedContrySearchView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit

final class SelectedCountrySearchView: UIView {
    
    //MARK: - UI elements
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Images.backButton, for: .normal)
        
        return button
    }()
    
    private(set) lazy var replaceButton: UIButton = {
        let size = CGSize(width: Constants.rightButtonSize,
                          height: Constants.rightButtonSize)
        let frame = CGRect(origin: .zero, size: size)
        let button = UIButton(frame: frame)
        
        button.setImage(Images.sortButton, for: .normal)
        
        return button
    }()
    
    private(set) lazy var departureTextField: UITextField = {
        let textField = UITextField()
        let placeholder = NSAttributedString(
            string: StringConstants.departurePlaceholder,
            attributes: [
                .font : Fonts.buttonText1,
                .foregroundColor : Colors.placeholderText
            ])
        
        textField.keyboardAppearance = .dark
        textField.borderStyle = .none
        textField.font = Fonts.buttonText1
        textField.textColor = Colors.text
        textField.attributedPlaceholder = placeholder
        textField.returnKeyType = .done
        textField.rightViewMode = .always
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.separator
        
        return view
    }()
    
    private(set) lazy var clearButton: UIButton = {
        let size = CGSize(width: Constants.rightButtonSize,
                          height: Constants.rightButtonSize)
        let frame = CGRect(origin: .zero, size: size)
        let button = UIButton(frame: frame)
        
        button.setImage(Images.clearButton, for: .normal)
        
        return button
    }()
    
    private(set) lazy var arrivalTextField: UITextField = {
        let textField = UITextField()
        let placeholder = NSAttributedString(
            string: StringConstants.arrivalPlaceholder,
            attributes: [
                .font : Fonts.buttonText1,
                .foregroundColor : Colors.placeholderText
            ])
        
        textField.keyboardAppearance = .dark
        textField.borderStyle = .none
        textField.font = Fonts.buttonText1
        textField.textColor = Colors.text
        textField.returnKeyType = .done
        textField.attributedPlaceholder = placeholder
        textField.rightViewMode = .always
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = Constants.vStackSpacing
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = Constants.hStackSpacing
        stack.alignment = .center
        stack.distribution = .fill
        
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

//MARK: - Extension with UITextFieldDelegate implementation

extension SelectedCountrySearchView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        
        let predicate = NSPredicate(format: StringConstants.regexFormat,
                                    StringConstants.cyrilicRegex)
        
        return predicate.evaluate(with: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        return true
    }
    
}

//MARK: - Extension with private methods

private extension SelectedCountrySearchView {
    
    func configuration() {
        backgroundColor = Colors.backgroud
        
        layer.cornerRadius = Constants.cornerRadius
        
        departureTextField.rightView = replaceButton
        arrivalTextField.rightView = clearButton
        
        vStack.addArrangedSubview(departureTextField)
        vStack.addArrangedSubview(separator)
        vStack.addArrangedSubview(arrivalTextField)
        
        hStack.addArrangedSubview(backButton)
        hStack.addArrangedSubview(vStack)
        
        addSubview(hStack)
    }
    
    func layout() {
        
        hStack.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.edgesOffset)
            $0.bottom.trailing.equalToSuperview()
                .inset(Constants.edgesOffset)
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.backButtonSize)
        }
    
        separator.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Constants.separatorHeight)
        }
    }
    
}

//MARK: - Extension with private subobjects

private extension SelectedCountrySearchView {
    
    enum Colors {
        static let backgroud = R.color.grey3()
        static let text = R.color.whiteTextColor()
        static let placeholderText = R.color.grey6() ?? .lightGray
        static let separator = R.color.grey4()
    }
    
    enum Constants {
        static let cornerRadius = 16.0
        static let vStackSpacing = 8.0
        static let hStackSpacing = 10.0
        static let rightButtonSize = 24.0
        static let backButtonSize = 24.0
        static let separatorHeight = 1.0
        static let edgesOffset = 16.0
    }
    
    enum StringConstants {
        static let arrivalPlaceholder = "Куда - Турция"
        static let departurePlaceholder = "Откуда - Москва"
        static let cyrilicRegex = "^[а-яА-ЯЁё\\.\\-]+$"
        static let regexFormat = "SELF MATCHES %@"
    }
    
    enum Images {
        static let backButton = R.image.leftArrow()
        static let sortButton = R.image.replaceArrows()
        static let clearButton = R.image.close()
    }
    
}
