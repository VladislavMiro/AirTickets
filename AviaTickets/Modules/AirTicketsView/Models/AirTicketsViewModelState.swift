//
//  AirTicketsViewModelState.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation

enum AirTicketsViewState {
    case cacheDownloaded(String)
    case downloaded
    case error(String)
}
