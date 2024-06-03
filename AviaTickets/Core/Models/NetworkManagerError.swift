//
//  NetworkManagerError.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import Foundation

enum NetworkManagerError: Error {
    case badURL(String)
    case networkError(String)
    case unknown(String)
}
