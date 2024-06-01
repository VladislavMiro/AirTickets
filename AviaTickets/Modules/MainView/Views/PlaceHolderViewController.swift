//
//  PlaceHolderViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit
import SnapKit

final class PlaceHolderViewController: UIViewController {
    
    //MARK: - Public properties
    
    public var labelText: String = .empty {
        didSet {
            label.text = labelText
        }
    }
    
    //MARK: - UI elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.textColor = Colors.text
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        layout()
    }
    
}

//MARK: - Extension with private methods

private extension PlaceHolderViewController {
    
    func configuration() {
        view.backgroundColor = R.color.grey4()
        view.addSubview(label)
    }
    
    func layout() {
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension PlaceHolderViewController {
    
    enum Colors {
        static let background = R.color.grey4()
        static let text = R.color.whiteTextColor()
    }
    
}

