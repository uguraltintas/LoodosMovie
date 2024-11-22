//
//  DetailViewController.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 1.0]
        return gradient
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var runTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Release Date"
        return label
    }()

    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateTitleLabel, releaseDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var genreTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Genre"
        return label
    }()

    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var genreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreTitleLabel, genreLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var releaseDateAndGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateStackView, genreStackView])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        return stackView
    }()

    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        return label
    }()

    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var overviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [overviewTitleLabel, overviewLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var writerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Writer"
        return label
    }()

    private lazy var writerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var writerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writerTitleLabel, writerLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Actors"
        return label
    }()

    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var actorsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actorsTitleLabel, actorsLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            movieInformationStackView,
            line(),
            releaseDateAndGenreStackView,
            line(),
            overviewStackView,
            line(),
            writerStackView,
            line(),
            actorsStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .background
        stackView.layer.cornerRadius = 32
        stackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        stackView.alignment = .leading
        return stackView
    }()

    private func line() -> UIView {
        let view = UIView()
        view.backgroundColor = .line
        view.translatesAutoresizingMaskIntoConstraints = false
        view.anchor(height: 1)
        view.tag = 11
        return view
    }

    private func labelWithImage(_ image: UIImage, text: String) -> UIStackView {
        image.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.anchor(width: 16, height: 16)

        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .text
        label.text = text

        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }

    private var viewModel: DetailViewModelProtocol
    private var imageViewTopConstraint: NSLayoutConstraint!

    init(viewModel: DetailViewModelProtocol) {
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
        viewModel.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.sublayers?.first(where: { $0 is CAGradientLayer })?.frame = imageView.bounds
        stackView.subviews
            .filter { $0.tag == 11 }
            .forEach { subview in
                subview.anchor(leading: stackView.leadingAnchor,
                               trailing: stackView.trailingAnchor,
                               paddingLeading: 25,
                               paddingTrailing: 25)
            }
    }

    func setupUI() {
        view.backgroundColor = .background
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
        scrollViewContainer.anchor(top: scrollView.topAnchor,
                                   leading: scrollView.leadingAnchor,
                                   bottom: scrollView.bottomAnchor,
                                   trailing: scrollView.trailingAnchor,
                                   paddingBottom: 40)
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        scrollViewContainer.addArrangedSubview(imageView)
        scrollViewContainer.addArrangedSubview(stackView)
        imageView.anchor(height: 500)
        scrollView.contentInsetAdjustmentBehavior = .never
        stackView.anchor(top: imageView.bottomAnchor, paddingTop: -100)

        stackView.bringSubviewToFront(imageView)
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewTopConstraint.isActive = true
        imageView.addGradient(colors: [.clear, .black.withAlphaComponent(0.8)] )

        titleLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, paddingTop: 25, paddingLeading: 25)



        view.addCustomBackButton {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY < 0 {
            imageViewTopConstraint.constant = offsetY
        } else {
            imageViewTopConstraint.constant = 0
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func handleViewModelOutput(_ output: DetailViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            DispatchQueue.main.async { [self] in
                if !isLoading {
                    dismissLoading()
                    return
                }
                showLoading()
            }
        case .showMovie:
            guard let movie = viewModel.movie,
                  let url = URL(string: movie.poster) else { return }
            DispatchQueue.main.async { [self] in
                imageView.kf.setImage(with: url)
                titleLabel.text = movie.title
                movieInformationStackView.addArrangedSubview(labelWithImage(UIImage(systemName: "clock") ?? UIImage(), text: movie.runtime))
                movieInformationStackView.addArrangedSubview(labelWithImage(UIImage(systemName: "star.fill") ?? UIImage(), text: movie.imdbRating))
                releaseDateLabel.text = movie.released
                genreLabel.text = movie.genre
                overviewLabel.text = movie.plot
                writerLabel.text = movie.writer ?? ""
                actorsLabel.text = movie.actors
            }
        }
    }
}
