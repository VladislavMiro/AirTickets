//
//  SelectedCountryViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation
import Combine

final class SelectedCountryViewModel {
    
    //MARK: - Public properties
    
    public var departure: AnyPublisher<String, Never> {
        departureData.eraseToAnyPublisher()
    }
    
    public var arrival: AnyPublisher<String, Never> {
        arrivalData.eraseToAnyPublisher()
    }
    
    public var sibscribeOnThePrice: AnyPublisher<Bool, Never> {
        subscribeData.eraseToAnyPublisher()
    }
    
    public var ticketOffersDowloadedPublisher: AnyPublisher<Void, Never> {
        isTicketOffersDownloaded.eraseToAnyPublisher()
    }
    
    public var isUpdateItemsView: AnyPublisher<Void, Never> {
        updateItemsView.eraseToAnyPublisher()
    }
    
    public var isNetworkError: AnyPublisher<String, Never> {
        networkErrorPublisher.eraseToAnyPublisher()
    }
    
    public var ticketOffers: [TicketOffersCellOutput] = []
    public var itemData: SelectedCountryItemData
    
    
    //MARK: - Private properties
    
    private let arrivalData: CurrentValueSubject<String, Never>
    private let departureData: CurrentValueSubject<String, Never>
    private let subscribeData: CurrentValueSubject<Bool, Never>
    private let isTicketOffersDownloaded: PassthroughSubject<Void, Never>
    private let networkErrorPublisher: PassthroughSubject<String, Never>
    private let updateItemsView: PassthroughSubject<Void, Never>
    
    private var ticketsOffersData: [Ticket]
    private var departureDayData: Date
    private var returningDayData: Date?

    private let coordinator: SelectedCountryViewCoordinatorPorotocol
    private let networkManager: SelectedCountryNetworkManagerProtocol
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - Initialaizers
    
    public init(arrivalData: String, 
                departureData: String,
                coordinator: SelectedCountryViewCoordinatorPorotocol,
                networkManager: SelectedCountryNetworkManagerProtocol) {
        self.arrivalData = CurrentValueSubject<String, Never>(arrivalData)
        self.departureData = CurrentValueSubject<String, Never>(departureData)
        self.coordinator = coordinator
        self.networkManager = networkManager
        
        subscribeData = CurrentValueSubject<Bool, Never>(false)
        isTicketOffersDownloaded = PassthroughSubject<Void, Never>()
        networkErrorPublisher = PassthroughSubject<String, Never>()
        updateItemsView = PassthroughSubject<Void, Never>()
        
        itemData = SelectedCountryItemData(departureDay: .empty,
                                           ticketClassAndPassangerNumber: .empty)
        departureDayData = Date.now
        ticketsOffersData = []
        ticketOffers = []
        cancelable = []
        
        itemData.departureDay = convertDate(date: departureDayData)
        itemData.ticketClassAndPassangerNumber = StringConstants.ticketClassAndPassangerNumber
    }
    
}

//MARK: - Extension with SelectedCountryViewModelProtocol implementation

extension SelectedCountryViewModel: SelectedCountryViewModelProtocol {
    
    public func popView() {
        coordinator.popView()
    }
    
    public func setArrival(data: String) {
        arrivalData.send(data)
    }
    
    public func setDeparture(data: String) {
        departureData.send(data)
    }
    
    public func setDate(type:  SelectedCountryItemType, data: Date) {
        if type == .departureDate && data <= Date.now {
            departureDayData = data
            itemData.departureDay = convertDate(date: data)
        }
        
        if type == .returningDay && data > departureDayData {
            returningDayData = data
            itemData.returningDay = convertDate(date: data)
        }
     
        updateItemsView.send()
    }
    
    public func subscribeOnThePrice(data: Bool) {
        subscribeData.send(data)
    }
    
    public func showTicketsListView() {
        let arrival = arrivalData.value
        let departure = departureData.value
        
        coordinator.showTicketsListView(departureData: departure, arrivalData: arrival)
    }
    
    public func fetchData() {
       
        networkManager.fetchTicketOffers()
            .map { $0.ticketsOffers }
            .sink { [unowned self] response in
            switch response {
            case .finished:
                break
            case .failure(let error):
                networkErrorPublisher.send(error.localizedDescription)
            }
        } receiveValue: { [unowned self] data in
            ticketsOffersData = data
            ticketOffers = data.map { convertTicketOffers(data: $0) }
            isTicketOffersDownloaded.send()
        }.store(in: &cancelable)

    }
    
    public func replaceData() {
        let arrival = arrivalData.value
        let departure = departureData.value
    
        arrivalData.send(departure)
        departureData.send(arrival)
    }
    
}

//MARK: - Extension with private methods

private extension SelectedCountryViewModel {
    
    func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: StringConstants.localeCode)
        dateFormatter.dateFormat = StringConstants.dateFormat
        
        return dateFormatter.string(from: date)
    }
    
    func convertTicketOffers(data: Ticket) -> TicketOffersCellOutput {
        let number = NSNumber(integerLiteral: data.price)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = .zero
        numberFormatter.currencyCode = StringConstants.currencyCode
        
        let price = numberFormatter.string(from: number) ?? .empty
        
        var timeRange = String()
        
        data.timeRange.forEach { item in
            timeRange += item + .space
        }
        
        timeRange = timeRange.trimmingCharacters(in: .whitespaces)

        let ticketOffer = TicketOffersCellOutput(id: data.id,
                                                  title: data.title,
                                                  timeRange: timeRange,
                                                  price: price)
        
        return ticketOffer
    }
    
}


//MARK: - Extension with private subobjects

private extension SelectedCountryViewModel {
    
    enum StringConstants {
        static let currencyCode = "RUB"
        static let dateFormat = "d MMM, EE"
        static let localeCode = "ru-RU"
        static let ticketClassAndPassangerNumber = "1, эконом"
    }
    
}
