//
//  NetworkManager.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation
import Combine

final class NetworkManager {
    
    //MARK: - Private properties
    
    private let session = URLSession.shared
    private var cancelable = Set<AnyCancellable>()
    
    
}

extension NetworkManager: AirTicketsNetworkManagerProtocol {
    
    public func fetchMusicTravelOffers() -> Future<AirTicketsNetworkResponse, Error> {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        urlComponents.path = "/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd"
        
        return Future { [unowned self] promise in
            
            guard let url = urlComponents.url else {
                promise(.failure(URLError(.badURL)))
                return
            }
            
            self.session.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: AirTicketsNetworkResponse.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { data in
                    promise(.success(data))
                }.store(in: &cancelable)
        }
    }
    
    
}

extension NetworkManager: SelectedCountryNetworkManagerProtocol {
    
    public func fetchTicketOffers() -> Future<SelectedCountryNetworkResponse, any Error> {
        var urlComponents = URLComponents()
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        urlComponents.path = "/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017"
        
        return Future { [unowned self] promise in
            
            guard let url = urlComponents.url else {
                promise(.failure(URLError(.badURL)))
                return
            }
            
            self.session.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: SelectedCountryNetworkResponse.self, decoder: decoder)
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { data in
                    promise(.success(data))
                }.store(in: &cancelable)
        }
    }
    
}

extension NetworkManager: TicketsListNetworkManagerProtocol {
    
    public func fetchAllTickets() -> Future<TicketsListNetworkResponse, any Error> {
        var urlComponents = URLComponents()
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        urlComponents.path = "/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        
        return Future { [unowned self] promise in
            
            guard let url = urlComponents.url else {
                promise(.failure(URLError(.badURL)))
                return
            }
            
            self.session.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: TicketsListNetworkResponse.self, decoder: decoder)
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { data in
                    promise(.success(data))
                }.store(in: &cancelable)
        }
    }
    
    
}
