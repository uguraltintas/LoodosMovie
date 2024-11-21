//
//  LoadingView.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import UIKit

class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .loodosBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.2)
        addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
        backgroundView.center(inView: self)
        backgroundView.setDimensions(width: 120, height: 120)
        activityIndicator.transform = .init(scaleX: 1.5, y: 1.5)
        activityIndicator.center(inView: backgroundView)
        backgroundView.layer.cornerRadius = 12
        activityIndicator.startAnimating()
    }
}
