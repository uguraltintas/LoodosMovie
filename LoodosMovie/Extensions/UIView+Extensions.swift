//
//  UIView+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeading: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        if let top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }

        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }

        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func center(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func centerY(inView view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func setDimensions(width: CGFloat, height: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func addConstraintsToFillView(_ view: UIView) {
        anchor(top: view.topAnchor, leading: view.leadingAnchor,
               bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
