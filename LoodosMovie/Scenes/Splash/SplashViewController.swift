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

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.stopMonitoring()
    }

    func setupUI() {
        view.backgroundColor = .loodosBlue
        view.addSubview(loodosLabel)
        loodosLabel.center(inView: self.view)
    }

    func checkConnection() {
        viewModel.checkInternetConnection { [weak self] isConnected in
            if !isConnected {
                self?.showAlert(title: "no_internet_title".localized,
                                message: "no_internet_message".localized)
                return
            }
            self?.loodosLabel.text = self?.viewModel.fetchRemoteConfigValue()
        }
    }
}
