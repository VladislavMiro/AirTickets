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
    
    func convertTickets(data: Ticket) -> TicketOutput {
        let luggage = LuggageOutput(hasLuggage: data.luggage.hasLuggage,
                                    price: data.luggage.price?
            .value.description ?? .empty)
        return TicketOutput(badge: data.badge,
                            price: data.price.value.description,
                            providerName: data.providerName,
                            company: data.company,
                            departure: data.departure,
                            arrival: data.arrival,
                            hasTransfer: data.hasTransfer,
                            hasVisaTransfer: data.hasVisaTransfer,
                            luggage: luggage,
                            handLuggage: data.handLuggage,
                            isReturnable: data.isReturnable,
                            isExchangable: data.isExchangable)
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewModel {
    
    enum StringConstants {
        static let dateFormat = "d MMMM"
        static let lacaleFormat = "ru-Ru"
    }
    
}

