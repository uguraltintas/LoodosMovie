//
//  HomeViewController.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import UIKit

fileprivate enum ViewState {
    case emptyState
    case noResults
    case showingResults
}

class HomeViewController: UIViewController {
    private lazy var searchController: UISearchController = {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.leftView?.tintColor = .text
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "search_movies_placeholder".localized, attributes: [.foregroundColor: UIColor.text])
        return searchController
    }()

    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .interactive
        return collectionView
    }()

    private lazy var emptyStateView: UIStackView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setDimensions(width: 100, height: 100)

        let label = UILabel()
        label.text = "search_placeholder_message".localized
        label.textColor = .text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var noResultsView: UIStackView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "text.page.badge.magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setDimensions(width: 100, height: 100)

        let label = UILabel()
        label.text = "no_results_message".localized
        label.textColor = .text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var viewModel: HomeViewModelProtocol

    private var viewState: ViewState = .emptyState {
        didSet {
            updateView()
        }
    }

    init(viewModel: HomeViewModelProtocol) {
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
        movieCollectionView.isHidden = true
        noResultsView.isHidden = true
        title = "home".localized
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options,
                                                                completionHandler: { _, _ in })
        UIApplication.shared.registerForRemoteNotifications()
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(movieCollectionView)
        view.addSubview(emptyStateView)
        view.addSubview(noResultsView)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        movieCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   paddingTop: 12,
                                   paddingLeading: 24,
                                   paddingTrailing: 24)
        emptyStateView.center(inView: self.view)
        emptyStateView.anchor(leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: 48,
                              paddingTrailing: 48)
        noResultsView.center(inView: self.view)
        noResultsView.anchor(leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: 48,
                              paddingTrailing: 48)
    }

    private func updateView() {
        DispatchQueue.main.async { [self] in
            switch viewState {
            case .emptyState:
                emptyStateView.isHidden = false
                noResultsView.isHidden = true
                movieCollectionView.isHidden = true
            case .noResults:
                emptyStateView.isHidden = true
                noResultsView.isHidden = false
                movieCollectionView.isHidden = true
            case .showingResults:
                emptyStateView.isHidden = true
                noResultsView.isHidden = true
                movieCollectionView.isHidden = false
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 8
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: 270)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeCollectionViewCell.identifier,
                for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(movie: viewModel.movies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchController.resignFirstResponder()
        viewModel.selectedItem(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 2 && viewModel.hasMoreMovies {
            guard let text = searchController.searchBar.text else { return }
            viewModel.fetchMovies(text: text)
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        search(text)
    }

    private func search(_ text: String) {
        if text.isEmpty {
            viewState = .emptyState
            return
        }
        viewModel.clearData()
        viewModel.fetchMovies(text: text)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            DispatchQueue.main.async { [self] in
                if !isLoading {
                    dismissLoading()
                    return
                }
                showLoading()
            }
        case .showMovies:
            if viewModel.movies.isEmpty {
                viewState = .noResults
                return
            }
            DispatchQueue.main.async { [self] in
                movieCollectionView.reloadData()
                viewState = .showingResults
            }
        }
    }

    func route(to route: HomeViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = DetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
