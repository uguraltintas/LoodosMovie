//
//  DetailScreenEvents.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//


enum DetailScreenEvents: AnalyticsEvent {
    case viewedDetailScreen(movie: Movie)

    var name: String {
        switch self {
        case .viewedDetailScreen: "viewed_detail_screen"
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .viewedDetailScreen(let movie):
            movie.toDictionary()
        }
    }

    var providers: [AnalyticsProvider] {
        [.firebase]
    }
}
