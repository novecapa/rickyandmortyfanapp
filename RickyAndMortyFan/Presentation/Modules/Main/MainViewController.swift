//
//  MainViewController.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//  
//

import UIKit

final class MainViewController: UIViewController {

    static let identifier = "MainViewController"

    enum Constants {
        // Collection View
        static let cornerRadius: CGFloat = 2.0
        static let spaicing: CGFloat = 2.0
        static let padding: CGFloat = 4.0
        static let columns: CGFloat = 2
    }

	var viewModel: MainViewModelProtocol!

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.returnKeyType = .search
            searchBar.tintColor = .white
            searchBar.placeholder = NSLocalizedString("Search by name", comment: "")
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    @IBOutlet weak var collectionCharacters: UICollectionView! {
        didSet {
            collectionCharacters.delegate = self
            collectionCharacters.dataSource = self
            collectionCharacters.register(UINib(nibName: CharacterCell.identifier,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: CharacterCell.identifier)
            collectionCharacters.layer.cornerRadius = Constants.cornerRadius
            collectionCharacters.layer.masksToBounds = true
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = Constants.spaicing
            layout.minimumInteritemSpacing = Constants.spaicing
            collectionCharacters.setCollectionViewLayout(layout, animated: true)
        }
    }

	// MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionCharacters.collectionViewLayout.invalidateLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionCharacters.collectionViewLayout.invalidateLayout()
    }

    private func setupBindings() {
        viewModel.startActivityIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
        }

        viewModel.stopActivityIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.refreshList = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionCharacters.reloadData()
            }
        }
        viewModel.scrollToTop = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.characters.count ?? 0 > 0 {
                    self?.collectionCharacters.setContentOffset(.zero, animated: true)
                }
            }
        }
    }
}

// MARK: Collection Delegates
extension MainViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                         for: indexPath) as? CharacterCell {
            cell.cellData = viewModel.characters[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewSize = (collectionView.frame.size.width - Constants.padding)/Constants.columns
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.characters[indexPath.row]
        viewModel.showCharacterDetail(characterId: item.id)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.characters.count - 1 {
            viewModel.fetchCharacters()
        }
    }
}

// MARK: Search bar delegates
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text ?? "").isEmpty {
            return
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetPagination()
        viewModel.fetchCharacters()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.resetPagination()
            viewModel.fetchCharacters()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchStringAction()
    }

    func searchStringAction() {
        guard let searchString = searchBar.text, !searchString.isEmpty else { return }
        viewModel.resetPagination()
        viewModel.filterCharacters(name: searchString)
    }
}
