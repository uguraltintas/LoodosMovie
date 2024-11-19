//
//  SearchRequest.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation
import Alamofire

struct SearchRequest: Endpoint {
    typealias Response = MovieSearchResponse

    var path: String
    var method: Alamofire.HTTPMethod
    var queryItems: [URLQueryItem]?

    init(text: String) {
        self.path = ""
        self.queryItems = [.init(name: "s", value: text)]
        self.method = .get
    }
}