//
//  Encodable+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 22.11.2024.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary
        } catch {
            debugPrint("Error converting model to dictionary: \(error)")
            return nil
        }
    }
}
