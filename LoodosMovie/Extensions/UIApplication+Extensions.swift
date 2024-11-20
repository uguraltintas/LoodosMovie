//
//  UIApplication+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import UIKit

extension UIApplication {

    var currentKeyWindow: UIWindow? {
        guard #available(iOS 13.0, *) else { return keyWindow }
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first
    }
}
