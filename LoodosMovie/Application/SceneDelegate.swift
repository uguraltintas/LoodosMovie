//
//  SceneDelegate.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let apiClient = APIClient()
        let networkMonitor = NetworkMonitor()
        let viewModel = SplashViewModel(networkMonitor: networkMonitor, apiClient: apiClient)
        let rootViewController = UINavigationController(rootViewController: SplashViewController(viewModel: viewModel))
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

