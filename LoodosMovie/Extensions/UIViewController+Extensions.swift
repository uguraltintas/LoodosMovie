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

    private static var loadingViewTag: Int { return 999999 }

    func showLoading() {
        if let _ = view.viewWithTag(UIViewController.loadingViewTag) { return }
        let loadingView = LoadingView(frame: view.bounds)
        loadingView.tag = UIViewController.loadingViewTag
        view.addSubview(loadingView)
    }

    func dismissLoading() {
        view.viewWithTag(UIViewController.loadingViewTag)?.removeFromSuperview()
    }
}
