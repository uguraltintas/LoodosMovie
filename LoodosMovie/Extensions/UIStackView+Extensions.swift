//
//  UIStackView+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 22.11.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
