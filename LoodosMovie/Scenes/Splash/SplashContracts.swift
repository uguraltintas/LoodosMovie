//
//  SplashContracts.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import Foundation

protocol SplashViewModelProtocol{
    var delegate: SplashViewModelDelegate? { get set }
    func checkInternetConnection()
}

protocol SplashViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SplashViewModelOutput)
    func route(to route: SplashViewRoute)
}

enum SplashViewRoute {
    case home(HomeViewModelProtocol)
}

enum SplashViewModelOutput {
    case showText(_ text: String)
    case showAlert
    case dismissAlert
}
