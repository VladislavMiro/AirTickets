//
//  UITextField + Extensions.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text ?? .empty }
            .eraseToAnyPublisher()
    }
    
    var textChangingDidEndPublisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .eraseToAnyPublisher()
    }
    
    var textChangingBeginPublisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidBeginEditingNotification, object: self)
            .eraseToAnyPublisher()
    }
    
}
