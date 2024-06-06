//
//  TicketsListViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation

final class TicketsListViewModel {
    
    //MARK: - Public properties
    
    private(set) var title: String = .empty
    private(set) var subtitle: String = .empty
    
    //MARK: - Private properties
    
    private let departue: String
    private let arrival: String
    private let numberOfPassangers: Int
    private let departureDay: Date
    private let coordinator: TicketsListViewCoordinatorProtocol
    
    //MARK: - Initialaizer
    
    public init(departue: String, arrival: String,
                departureDay: Date,  numberOfPassangers: Int,
                coordinator: TicketsListViewCoordinatorProtocol) {
        self.departue = departue
        self.arrival = arrival
        self.coordinator = coordinator
        self.departureDay = departureDay
        self.numberOfPassangers = numberOfPassangers
        
        prepareData()
    }
    
}

//MARK: - Extension with TicketsListViewModelProtocol implementation

extension TicketsListViewModel: TicketsListViewModelProtocol {

    public func popView() {
        coordinator.popView()
    }
    
    
}

//MARK: - Extension with private methods

private extension TicketsListViewModel {
    
    func prepareData() {
        title = String(format: "%@-%@", departue, arrival)
        
        let date = formatDate(date: departureDay)
        
        subtitle = String(format: "%@, %i пассажир", date, numberOfPassangers)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: StringConstants.lacaleFormat)
        dateFormatter.dateFormat = StringConstants.dateFormat
        
        return dateFormatter.string(from: date)
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewModel {
    
    enum StringConstants {
        static let dateFormat = "d MMMM"
        static let lacaleFormat = "ru-Ru"
    }
    
}

