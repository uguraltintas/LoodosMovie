//
//  SplashViewModel.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation
import FirebaseRemoteConfig

final class SplashViewModel: SplashViewModelProtocol {
    weak var delegate: SplashViewModelDelegate?
    private var networkMonitor: NetworkMonitorProcotol
    private var apiClient: APIClientProtocol
    private var isAlertPresented = false
    private var dispatchWorkItem: DispatchWorkItem?

    init(networkMonitor: NetworkMonitorProcotol,
         apiClient: APIClientProtocol) {
        self.networkMonitor = networkMonitor
        self.apiClient = apiClient
    }

    deinit {
        stopMonitoring()
    }

    func fetchText() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let text = remoteConfig.configValue(forKey: "loodosText").stringValue
        notify(.showText(text))
        dispatchWorkItem = .init(block: {
            let viewModel = HomeViewModel(apiClient: self.apiClient)
            self.delegate?.route(to: .home(viewModel))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: dispatchWorkItem ?? .init(block: {}))
    }

    func checkInternetConnection() {
        networkMonitor.delegate = self
        startMonitoring()
    }

    private func startMonitoring() {
        networkMonitor.startMonitoring()
    }

    private func stopMonitoring() {
        networkMonitor.stopMonitoring()
    }

    private func notify(_ output: SplashViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

extension SplashViewModel: NetworkMonitorDelegate {
    func networkMonitor(didChangeConnectionStatus isConnected: Bool) {
        if !isConnected {
            notify(.showAlert)
            self.isAlertPresented = true
            dispatchWorkItem?.cancel()
            return
        }
        if isAlertPresented {
            notify(.dismissAlert)
            self.isAlertPresented = false
        }
        fetchText()
    }
}
