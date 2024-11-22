//
//  AnalyticsManager.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

protocol AnalyticsProviderProtocol {
    var configuration: AnalyticsConfiguration { get }
}

enum AnalyticsProvider: AnalyticsProviderProtocol {
    case firebase

    public var configuration: AnalyticsConfiguration {
        switch self {
        case .firebase:
            FirebaseAnalyticsConfiguration()
        }
    }
}
