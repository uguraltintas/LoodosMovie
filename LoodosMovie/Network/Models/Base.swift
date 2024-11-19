//
//  Base.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation

protocol BaseResponse: Decodable {
    var response: String { get }
    var error: String? { get }

    var isSuccess: Bool { get }
}

extension BaseResponse {
    var error: String? { nil }

    var isSuccess: Bool {
        response.lowercased() == "true"
    }
}
