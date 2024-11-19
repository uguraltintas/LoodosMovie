//
//  String+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    func localize(arguments: CVarArg...) -> String {
        String.localizedStringWithFormat(NSLocalizedString(self, comment: ""), arguments)
    }
}
