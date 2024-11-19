//
//  NetworkError.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case badRequest
    case unknownError

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "invalid_url".localized
        case .noData:
            return "no_data".localized
        case .decodingError:
            return "decoding_error".localized
        case .serverError(let message):
            return "server_error".localize(arguments: message)
        case .badRequest:
            return "bad_request".localized
        case .unknownError:
            return "unknown_error".localized
        }
    }
}
