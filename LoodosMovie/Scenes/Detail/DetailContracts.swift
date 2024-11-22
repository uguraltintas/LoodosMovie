//
//  DetailContracts.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import Foundation

protocol DetailViewModelProtocol{
    var delegate: DetailViewModelDelegate? { get set }
    var id: String { get }
    var movie: Movie? { get }
    func load()
    func fetchMovie(id: String)
}

protocol DetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: DetailViewModelOutput)
}

enum DetailViewModelOutput {
    case setLoading(Bool)
    case showMovie
}
