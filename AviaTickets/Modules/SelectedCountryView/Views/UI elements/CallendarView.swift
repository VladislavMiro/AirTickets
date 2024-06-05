//
//  CalendarView.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 05.06.2024.
//

import UIKit
import Combine

final class CalendarView: UIControl {
    
    //MARK: - Public properties
    
    public var datePickerPublisher: AnyPublisher<Date, Never> {
        dateValue.eraseToAnyPublisher()
    }
    
    public var doneButtonPressedPublisher: AnyPublisher<Void, Never> {
        doneButtonPressed.eraseToAnyPublisher()
    }
    
    //MARK: - Private properties
    
    private let dateValue: PassthroughSubject<Date, Never>
    private let doneButtonPressed: PassthroughSubject<Void, Never>
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - UI elements
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(StringConstants.doneButton, for: .normal)
        button.setTitleColor(Colors.doneButtonTitleColor, for: .normal)
        button.addTarget(self,
                         action: #selector(doneButtonTapped),
                         for: .touchUpInside)
        button.setTitleColor(Colors.doneButtonTitleColor
            .withAlphaComponent(Constants.doneButtonAlphaColor),
                             for: .highlighted)
        button.sizeToFit()
        
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .trailing
        
        
        return stack
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        
        pickerView.datePickerMode = .date
        pickerView.preferredDatePickerStyle = .inline
        pickerView.addTarget(self,
                             action: #selector(dateValueChanged),
                             for: .valueChanged)
        
        return pickerView
    }()
    
    //MARK: - Initialaizers
    
    override init(frame: CGRect) {
        dateValue = PassthroughSubject<Date, Never>()
        doneButtonPressed = PassthroughSubject<Void, Never>()
        cancelable = []
        
        super.init(frame: frame)
        
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with private methods

private extension CalendarView {
    
    @objc func doneButtonTapped() {
        doneButtonPressed.send()
    }
    
    @objc func dateValueChanged() {
        dateValue.send(datePicker.date)
    }
    
    func configuration() {
        backgroundColor = Colors.background
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        
        
        let width = datePicker.bounds.width
        let height = datePicker.bounds.height + doneButton.bounds.height
        
        frame = CGRect(x: .zero,
                       y: .zero,
                       width: width,
                       height: height)
        
        addSubview(doneButton)
        addSubview(datePicker)
    }
    
    func layout() {
        
        doneButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
                .inset(Constants.doneButtonTrailingOffset)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(doneButton.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension CalendarView {
    
    enum Constants {
        static let cornerRadius = 8.0
        static let doneButtonTrailingOffset = 16.0
        static let doneButtonAlphaColor = 0.6
    }
    
    enum StringConstants {
        static let doneButton = "Готово"
    }
    
    enum Colors {
        static let background = R.color.grey3()
        static let doneButtonTitleColor = UIColor.systemBlue
    }
    
}
