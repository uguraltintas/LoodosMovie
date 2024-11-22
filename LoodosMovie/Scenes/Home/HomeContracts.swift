//
//  HomeContracts.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 20.11.2024.
//

import Foundation

protocol HomeViewModelProtocol{
    var delegate: HomeViewModelDelegate? { get set }
    var movies: [SearchMovieResult] { get }
    var hasMoreMovies: Bool { get }
    func fetchMovies(text: String)
    func selectedItem(at index: Int)
    func clearData()
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: HomeViewModelOutput)
    func route(to route: HomeViewRoute)
}

enum HomeViewRoute {
    case detail(DetailViewModelProtocol)
}

enum HomeViewModelOutput {
    case setLoading(Bool)
    case showMovies
}
