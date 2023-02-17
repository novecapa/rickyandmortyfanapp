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

	var viewModel: MainViewModelProtocol!

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.returnKeyType = .search
            searchBar.tintColor = .white
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
            collectionCharacters.layer.cornerRadius = 2.0
            collectionCharacters.layer.masksToBounds = true
        }
    }
    
	// MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()
    }

    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.viewDidAppear()
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
                if (self?.viewModel.getCharacterList().count ?? 0 > 0) {
                    self?.collectionCharacters.setContentOffset(CGPoint.zero,
                                                                animated: true)
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
        return viewModel.getCharacterList().count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                         for: indexPath) as? CharacterCell {
            cell.cellData = viewModel.getCharacterList()[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 4
        let collectionViewSize = (collectionView.frame.size.width - padding)/2

        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getCharacterList()[indexPath.row]
        viewModel.showCharacterDetail(characterId: item.id)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.getCharacterList().count - 1 {
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
        guard let searchString = searchBar.text else { return }
        if searchString.isEmpty {
            return
        }
        viewModel.resetPagination()
        viewModel.filterCharacters(name: searchString)
    }
}
