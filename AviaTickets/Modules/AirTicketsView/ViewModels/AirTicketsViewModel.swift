//
//  AirTicketsViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import Foundation
import Combine

final class AirTicketsViewModel {
    
    //MARK: - Public properties
    
    public var departure: String
    private(set) var offers: [Offer]
    
    public var statePublisher: AnyPublisher<AirTicketsViewState, Never> {
        state.eraseToAnyPublisher()
    }
    
    //MARK: - Private properties
    
    private let state: PassthroughSubject<AirTicketsViewState, Never>
    private let networkManager: AirTicketsNetworkManagerProtocol
    private let coordinator: AirTicketsViewCoordinatorProtocol
    private var cancelable: Set<AnyCancellable>
    
    public init(coordinator: AirTicketsViewCoordinatorProtocol, networkManager: AirTicketsNetworkManagerProtocol) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        
        departure = .empty
        offers = []
        state = PassthroughSubject<AirTicketsViewState, Never>()
        cancelable = []
    }
    
}

//MARK: - Extension with AirTicketsViewModelProtocol

extension AirTicketsViewModel: AirTicketsViewModelProtocol {
    
    public func fetchData() {
        networkManager.fetchMusicTravelOffers()
            .sink { [unowned self] error in
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    state.send(.error(error.localizedDescription))
                }
            } receiveValue: { [unowned self] data in
                offers  = data.offers
                state.send(.downloaded)
            }.store(in: &cancelable)
    }
    
    public func cachedInputData() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.setValue(departure, forKey: Constants.cacheKey)
    }
    
    public func loadCachedData() {
        let userDefaults = UserDefaults.standard
        
        guard let cache = userDefaults.string(forKey: Constants.cacheKey)
        else { return }

        departure = cache
        state.send(.cacheDownloaded(cache))
    }
    
    public func showSearchView() {
        coordinator.showSearchView(data: departure)
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsViewModel {
    
    enum Constants {
        static let cacheKey = "departureTextFieldCache"
    }
    
}
