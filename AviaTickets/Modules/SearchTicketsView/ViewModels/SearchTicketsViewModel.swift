//
//  SearchTicketsViewModel.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import Foundation
import Combine

final class SearchTicketsViewModel {
    
    //MARK: - Public properties
    
    public var arrival: AnyPublisher<String, Never> {
        arrivalData.eraseToAnyPublisher()
    }
    
    private(set) var departure: String
    private(set) var cities: [City]
    
    //MARK: - Private properties
    
    private let coordinator: SearchTicketsViewCoordinatorProtocol
    private let arrivalData: CurrentValueSubject<String, Never>
    
    //MARK: - Initialaizers
    
    public init(coordinator: SearchTicketsViewCoordinatorProtocol, data: String) {
        self.coordinator = coordinator
        self.departure = data
        
        arrivalData = CurrentValueSubject<String, Never>(.empty)

        cities = [
            City(image: "City1", name: "Стамбул", description: "Популярное направление"),
            City(image: "City2", name: "Сочи", description: "Популярное направление"),
            City(image: "City3", name: "Пхукет", description: "Популярное направление")
        ]
    }
    
}

//MARK: - Extension with SearchTicketsViewModel implementation

extension SearchTicketsViewModel: SearchTicketsViewModelProtocol {
    
    public func setArrival(data: String) {
        arrivalData.send(data)
    }
    
    public func buttonTapped(type: SearchViewButtonType) {
        switch type {
        case .dificultRoute:
            coordinator.showDificultDirrectionView()
        case .somewhere:
            arrivalData.send("Куда угодно")
        case .weekend:
            coordinator.showWeekendView()
        case .hotTickets:
            coordinator.showHotTicketsView()
        }
    }
    
    public func selectRow(at index: Int) {
        let city = cities[index]
        arrivalData.send(city.name)
        coordinator.showSelectedCountryView(arrivalData: arrivalData.value)
    }
    
    public func didFinish() {
        coordinator.didFinishView()
    }
    
}
