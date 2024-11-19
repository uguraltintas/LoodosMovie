//
//  ErrorResponse.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation

struct ErrorResponse: BaseResponse {
    let response: String
    let error: String?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
