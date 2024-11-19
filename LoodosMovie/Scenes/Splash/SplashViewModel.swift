//
//  SplashViewModel.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation
import Network
import FirebaseRemoteConfig

final class SplashViewModel {
    private let networkMonitor = NetworkMonitor()

    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        networkMonitor.onConnectionStatusChange = completion
        startMonitoring()
    }

    func startMonitoring() {
        networkMonitor.startMonitoring()
    }

    func stopMonitoring() {
        networkMonitor.stopMonitoring()
    }

    func fetchRemoteConfigValue() -> String {
        let remoteConfig = RemoteConfig.remoteConfig()
        return remoteConfig.configValue(forKey: "loodosText").stringValue
    }
}
