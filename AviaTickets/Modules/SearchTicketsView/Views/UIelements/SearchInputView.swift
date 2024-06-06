//
//  SearchInputView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit
import Combine

final class SearchInputView: UIView {
    
    //MARK: - Public properties
    
    public var keyboardDoneButtonPublisher : AnyPublisher<Void, Never> {
        doneButtonPublisher.eraseToAnyPublisher()
    }
    
    //MARK: - Private properties
    
    private let doneButtonPublisher : PassthroughSubject<Void, Never>

    //MARK: - UI elements
    
    private(set) lazy var departureTextField: SearchTextField = {
        let textField = SearchTextField()

        textField.isUserInteractionEnabled = false
        textField.leftViewImage = Images.departureTextField
        textField.rightViewMode = .never

        return textField
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.separator
        
        return view
    }()
    
    
    private(set) lazy var arrivalTextField: SearchTextField = {
        let textField = SearchTextField()
        let placeHolder = NSAttributedString(string: StringConstants.arrivalTextFieldPlaceholder,
                                             attributes: [.font : Fonts.buttonText1,
                                                          .foregroundColor : Colors.textFieldPlaceholder])
        
        textField.attributedPlaceholder = placeHolder
        textField.leftViewImage = Images.arrivalTextField
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = Constants.stackSpacing
        
        return stack
    }()
    
    //MARK: - Initialaizers
    
    override init(frame: CGRect) {
        doneButtonPublisher = PassthroughSubject<Void, Never>()
        
        super.init(frame: frame)
        
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with UITextFieldDelegate

extension SearchInputView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        
        let predicate = NSPredicate(format: StringConstants.regexFormat,
                                    StringConstants.cyrilicRegex)
        
        return predicate.evaluate(with: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        doneButtonPublisher.send()
        
        return true
    }
    
}

//MARK: - Extension with private methods

private extension SearchInputView {
    
    func configuration() {
        backgroundColor = Colors.background
        
        layer.cornerRadius = Constants.cornerRadius
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowColor = Colors.shadow
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = CGSize(width: Constants.shadowOffserWidth,
                                    height: Constants.shadowOffsetHeight)
        layer.shadowRadius = Constants.shadowRadius
        
        vStack.addArrangedSubview(departureTextField)
        vStack.addArrangedSubview(separator)
        vStack.addArrangedSubview(arrivalTextField)
        
        addSubview(vStack)
    }
    
    func layout() {
        vStack.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
                .offset(Constants.stackOffset)
            $0.bottom.trailing.equalToSuperview()
                .inset(Constants.stackOffset)
        
        }
        
        separator.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Constants.separatorHeight)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchInputView {
    
    enum Colors {
        static let background = R.color.grey3()
        static let textFieldPlaceholder = R.color.grey6() ?? .lightGray
        static let separator = R.color.grey4()
        static let shadow = R.color.backgroundBlackColor()?.cgColor
    }
    
    enum Constants {
        static let cornerRadius = 16.0
        static let stackSpacing = 8.0
        static let separatorHeight = 1.0
        static let stackOffset = 16.0
        static let shadowOpacity: Float = 0.5
        static let shadowRadius = 3.0
        static let shadowOffsetHeight = 3.0
        static let shadowOffserWidth = 0.0
    }
    
    enum StringConstants {
        static let arrivalTextFieldPlaceholder = "Куда - Турция"
        static let cyrilicRegex = "^[а-яА-ЯЁё\\.\\-]+$"
        static let regexFormat = "SELF MATCHES %@"
    }
    
    enum Images {
        static let departureTextField = R.image.plane2()
        static let arrivalTextField = R.image.search()
    }
    
}
