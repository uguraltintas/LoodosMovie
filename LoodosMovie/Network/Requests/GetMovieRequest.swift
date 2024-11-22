//
//  GetMovieRequest.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import Foundation
import Alamofire

struct GetMovieRequest: Endpoint {
    typealias Response = Movie

    var path: String
    var method: Alamofire.HTTPMethod
    var queryItems: [URLQueryItem]?

    init(id: String) {
        self.path = ""
        self.queryItems = [.init(name: "i", value: id)]
        self.method = .get
    }
}
