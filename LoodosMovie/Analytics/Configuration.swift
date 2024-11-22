//
//  AnalyticsManager.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//
import FirebaseAnalytics
import Firebase

protocol AnalyticsConfiguration {
    func logEvent<T: AnalyticsEvent>(_ event: T, parameters: [String: Any]?)
}


struct FirebaseAnalyticsConfiguration: AnalyticsConfiguration {
    func logEvent<T: AnalyticsEvent>(_ event: T, parameters: [String: Any]?) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
