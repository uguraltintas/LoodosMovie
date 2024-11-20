//
//  UIViewController+Extensions.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }

    func showAlert(title: String, message: String, actionTitle: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: completion)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
