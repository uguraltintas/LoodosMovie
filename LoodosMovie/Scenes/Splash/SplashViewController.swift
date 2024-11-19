//
//  SplashViewController.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

class SplashViewController: UIViewController {
    let viewModel = SplashViewModel()
    private let loodosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: .init(40), weight: .bold)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
    }

    func setupUI() {
        view.backgroundColor = .loodosBlue
        view.addSubview(loodosLabel)
        loodosLabel.center(inView: self.view)
    }

    func checkConnection() {
        Task {
            let isConnected = await viewModel.checkInternetConnection()
        }
    }
}
