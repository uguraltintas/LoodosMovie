//
//  SplashViewController.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

class SplashViewController: UIViewController {
    private lazy var loodosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: .init(40), weight: .bold)
        label.textColor = .white
        return label
    }()

    private var viewModel: SplashViewModelProtocol

    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.checkInternetConnection()
    }

    func setupUI() {
        view.backgroundColor = .loodosBlue
        view.addSubview(loodosLabel)
        loodosLabel.center(inView: self.view)
    }
}

extension SplashViewController: SplashViewModelDelegate {
    func handleViewModelOutput(_ output: SplashViewModelOutput) {
        switch output {
        case .showText(let text):
            DispatchQueue.main.async {
                self.loodosLabel.text = text
            }
        case .showAlert:
            DispatchQueue.main.async {
                self.showAlert(title: "no_internet_title".localized,
                               message: "no_internet_message".localized)
            }
        case .dismissAlert:
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }

    func route(to route: SplashViewRoute) {
        switch route {
        case .home(let viewModel):
            let homeViewController = HomeViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: homeViewController)
            guard let window = UIApplication.shared.currentKeyWindow else { return }
            window.rootViewController = navigationController
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
