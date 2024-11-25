//
//  HomeViewModel.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    private var allMovies: [SearchMovieResult] = []
    var movies: [SearchMovieResult] = []
    var currentPage = 1
    private var apiClient: APIClientProtocol
    var hasMoreMovies = true

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func clearData() {
        movies.removeAll()
        allMovies.removeAll()
        currentPage = 1
        notify(.showMovies)
    }

    func fetchMovies(text: String) {
        Task {
            do {
                notify(.setLoading(true))
                let request = SearchRequest(text: text, page: currentPage)
                let result = try await apiClient.send(request)
                guard let totalResults = Int(result.totalResults) else { return }
                allMovies.append(contentsOf: result.search)
                let filteredMovies = result.search.filter { !$0.poster.elementsEqual("N/A") }
                movies.append(contentsOf: filteredMovies)
                if !(totalResults > allMovies.count) {
                    hasMoreMovies = false
                }
                currentPage += 1
                notify(.showMovies)
            } catch {
                notify(.showMovies)
                debugPrint(error)
            }
            notify(.setLoading(false))
        }
    }

    func selectedItem(at index: Int) {
        let viewModel = DetailViewModel(id: movies[index].imdbID, apiClient: apiClient)
        delegate?.route(to: .detail(viewModel))
    }

    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
