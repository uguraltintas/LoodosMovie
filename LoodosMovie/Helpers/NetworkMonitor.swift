//
//  NetworkMonitor.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Network

protocol NetworkMonitorDelegate: AnyObject {
    func networkMonitor(didChangeConnectionStatus isConnected: Bool)
}

protocol NetworkMonitorProcotol {
    var delegate: NetworkMonitorDelegate? { get set }
    func startMonitoring()
    func stopMonitoring()
}

class NetworkMonitor: NetworkMonitorProcotol {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    weak var delegate: NetworkMonitorDelegate?

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            let isConnected = path.status == .satisfied
            delegate?.networkMonitor(didChangeConnectionStatus: isConnected)
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
