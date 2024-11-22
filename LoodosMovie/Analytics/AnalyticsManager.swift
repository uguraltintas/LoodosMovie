//
//  AnalyticsManager.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//


final class AnalyticsManager {
    static let shared = AnalyticsManager()
    private init() { }

    func logEvent<T: AnalyticsEvent>(_ event: T) {
        event.providers.forEach {
            $0.configuration.logEvent(event, parameters: event.parameters)
        }
    }
}
