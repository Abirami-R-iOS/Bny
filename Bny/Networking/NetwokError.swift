//
//  NetwokError.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation

enum NetworkError: LocalizedError {

    case invalidURL
    case noInternet
    case decodingError(String)
    case serverError(String)
    case unknown

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid URL"

        case .noInternet:
            return "No Internet Connection"

        case .decodingError(let message):
            return message

        case .serverError(let message):
            return message

        case .unknown:
            return "Something went wrong"
        }
    }
}
