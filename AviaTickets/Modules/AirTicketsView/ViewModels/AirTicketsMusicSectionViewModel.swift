//
//  AirTicketsMusicSectionViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation
import Combine

final class AirTicketsMusicSectionViewModel: AirTicketsMusicSectionViewModelProtocol {
    
    //MARK: - Public properties
    
    public var outputData: [AirTicketsMusicOffersOutput] = []
    
    //MARK: - Private properties
    
    private var data: [Offer]
    
    //MARK: - Initialalizers
    
    public init(data: [Offer]) {
        self.data = data
    }
    
    public func prepareData() {
        outputData = data.map { convertData(data: $0) }
    }
    
    private func convertData(data: Offer) -> AirTicketsMusicOffersOutput {
        let formatter = NumberFormatter()
        
        let number = NSNumber(integerLiteral: data.price)
        
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: StringConstants.localeCode)
        formatter.currencyCode = StringConstants.currencyCode
        formatter.maximumFractionDigits = .zero
        
        let price = formatter.string(from: number) ?? StringConstants.pricePlaceholder
        
        return AirTicketsMusicOffersOutput(image: String(data.id),
                                           title: data.title,
                                           town: data.town,
                                           price: price)
    }

}

//MARK: - Extension with private subobjects

private extension AirTicketsMusicSectionViewModel {
    
    enum StringConstants {
        static let localeCode = "ru-RU"
        static let currencyCode = "RUB"
        static let pricePlaceholder = "0"
    }
    
}
