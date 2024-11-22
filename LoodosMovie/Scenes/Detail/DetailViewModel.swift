//
//  DetailViewModel.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    weak var delegate: DetailViewModelDelegate?
    var id: String
    let apiClient: APIClientProtocol
    var movie: Movie?

    init(id: String, apiClient: APIClientProtocol) {
        self.id = id
        self.apiClient = apiClient
    }

    func load() {
        fetchMovie(id: id)
    }

    func fetchMovie(id: String) {
        Task {
            do {
                notify(.setLoading(true))
                let request = GetMovieRequest(id: id)
                movie = try await apiClient.send(request)
                notify(.showMovie)
                guard let movie else { return }
                AnalyticsManager.shared.logEvent(DetailScreenEvents.viewedDetailScreen(movie: movie))
            } catch {
                debugPrint(error)
            }
            notify(.setLoading(false))
        }
    }

    private func notify(_ output: DetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
