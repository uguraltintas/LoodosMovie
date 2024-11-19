//
//  Endpoint.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation
import Alamofire

protocol Endpoint {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
}

extension Endpoint {
    var baseURL: String { "https://www.omdbapi.com" }
    var queryItems: [URLQueryItem]? { nil }
    var url: URL? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            return nil
        }
        let apiKey = URLQueryItem(name: "apikey", value: key)
        var components = URLComponents(string: baseURL)
        components?.path = path
        var finalQueryItems = queryItems ?? []
        finalQueryItems.append(apiKey)
        components?.queryItems = finalQueryItems
        return components?.url
    }
}
