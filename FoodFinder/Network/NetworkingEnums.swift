//
//  NetworkingEnums.swift
//  FoodFinder
//
//  Created by Juan Carlos Perez on 21/12/20.
//

import Foundation

enum NetworkingError: Error {
    case noInternetConnection
    case badUrl
    case domainError(description: String, errorCode: Int)
    case badResponse
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Communications error"
        case .domainError(let descr, _):
            return descr
        case .badUrl:
            return "Invalid URL"
        case .badResponse:
            return "Invalid Response"
        }
    }
}
