//
//  HomeCollectionViewCell.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeCollectionViewCell"

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(height: 220)
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(stackView)
        stackView.addConstraintsToFillView(self)
    }

    func configure(movie: SearchMovieResult) {
        guard let url = URL(string: movie.poster) else { return }
        imageView.kf.setImage(with: url)
        titleLabel.text = movie.title
    }
}
