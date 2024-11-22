//
//  AnalyticsManager.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

protocol AnalyticsEvent {
    associatedtype T: AnalyticsProviderProtocol
    var name: String { get }
    var parameters: [String: Any]? { get }
    var providers: [T] { get }
}
