//
//  TicketsListViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import Foundation
import Combine

final class TicketsListViewModel {
    
    //MARK: - Public properties
    
    public var state: AnyPublisher<TicketsListState, Never> {
        statePublisher.eraseToAnyPublisher()
    }
    
    private(set) var title: String = .empty
    private(set) var subtitle: String = .empty
    private(set) var tickets: [TicketOutput]
    
    //MARK: - Private properties
    
    private let departue: String
    private let arrival: String
    private let numberOfPassangers: Int
    private let departureDay: Date
    private var ticketsData: [Ticket]
    
    private let statePublisher: PassthroughSubject<TicketsListState, Never>
    private var cancelable: Set<AnyCancellable>
    
    private let networkManager: TicketsListNetworkManagerProtocol
    private let coordinator: TicketsListViewCoordinatorProtocol
    
    //MARK: - Initialaizer
    
    public init(departue: String, arrival: String,
                departureDay: Date,  numberOfPassangers: Int,
                coordinator: TicketsListViewCoordinatorProtocol,
                networkManager: TicketsListNetworkManagerProtocol) {
        self.departue = departue
        self.arrival = arrival
        self.coordinator = coordinator
        self.departureDay = departureDay
        self.numberOfPassangers = numberOfPassangers
        self.networkManager = networkManager
        
        statePublisher = PassthroughSubject<TicketsListState, Never>()
        
        cancelable = []
        ticketsData = []
        tickets = []
        
        prepareData()
    }
    
}

//MARK: - Extension with TicketsListViewModelProtocol implementation

extension TicketsListViewModel: TicketsListViewModelProtocol {

    public func popView() {
        coordinator.popView()
    }
    
    public func didFinish() {
        coordinator.didFinish()
    }
    
    public func fetchData() {
        networkManager.fetchAllTickets()
            .map {  $0.tickets }
            .sink {  [unowned self] response in
                switch response {
                case .finished:
                    break
                case .failure(let error):
                    statePublisher.send(.networkError(error.localizedDescription))
                }
            } receiveValue: { [unowned self] data in
                ticketsData = data
                tickets = data.map { convertTickets(data: $0) }
                statePublisher.send(.downloaded)
            }.store(in: &cancelable)
    }
    
}

//MARK: - Extension with private methods

private extension TicketsListViewModel {
    
    func prepareData() {
        title = String(format: StringConstants.titleFormat, departue, arrival)
        
        let date = formatDate(date: departureDay)
        
        subtitle = String(format: StringConstants.subTitleFormat, date, numberOfPassangers)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: StringConstants.lacaleFormat)
        dateFormatter.dateFormat = StringConstants.dateFormat
        
        return dateFormatter.string(from: date)
    }
    
    func convertTickets(data: Ticket) -> TicketOutput {
        
        let price = convertCurrency(data: data.price.value)
        let arrivalTime = convertDate(data: data.arrival.date)
        let departureTime = convertDate(data: data.departure.date)
        let spentTime = calculateDate(departure: data.departure.date, arrival: data.arrival.date)
        
        return TicketOutput(badge: data.badge,
                            price: price,
                            departureTime: departureTime,
                            departureAirportCode: data.arrival.airport,
                            arrivalTime: arrivalTime,
                            arrivalAirportCode: data.arrival.airport,
                            spentTime: spentTime,
                            hasTransfer: data.hasTransfer)
    }
    
    func convertCurrency(data: Int) -> String {
        let number = NSNumber(integerLiteral: data)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = .zero
        numberFormatter.locale = Locale(identifier: StringConstants.lacaleFormat)
        numberFormatter.currencyCode = StringConstants.currencyCode
        
        return numberFormatter.string(from: number) ?? StringConstants.pricePlaceholder
    }
    
    func convertDate(data:  String) -> String {
        let dateFormatter = DateFormatter()
        
        guard let date = getDate(data: data)
        else { return StringConstants.timeDatePlaceholder }
        
        dateFormatter.locale = Locale(identifier: StringConstants.lacaleFormat)
        dateFormatter.dateFormat = StringConstants.timeDateFormat
        
        return dateFormatter.string(from: date)
    }
    
    func calculateDate(departure: String, arrival: String) -> String {
        guard let departure = getDate(data: departure),
              let arrival = getDate(data: arrival)
        else { return StringConstants.spentTimePlaceholder }
        
        let interval = departure.distance(to: arrival)
        let doubleInterval = Double(interval / 3600)
        
        let numberFormatter = NumberFormatter()
        let number = NSNumber(floatLiteral: doubleInterval)
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.decimalSeparator = .dot
        
        return numberFormatter.string(from: number) ?? StringConstants.spentTimePlaceholder
    }
    
    func getDate(data: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: StringConstants.posixLocaleFormat)
        dateFormatter.dateFormat = StringConstants.posixDateFormat
        
        return dateFormatter.date(from: data)
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewModel {
    
    enum StringConstants {
        static let dateFormat = "d MMMM"
        static let lacaleFormat = "ru-Ru"
        static let posixLocaleFormat = "en_US_POSIX"
        static let posixDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        static let currencyCode = "RUB"
        static let pricePlaceholder = "0 ₽"
        static let spentTimePlaceholder = "0"
        static let timeDateFormat = "hh:mm"
        static let timeDatePlaceholder = "00:00"
        static let titleFormat = "%@-%@"
        static let subTitleFormat = "%@, %i пассажир"
    }
    
}

