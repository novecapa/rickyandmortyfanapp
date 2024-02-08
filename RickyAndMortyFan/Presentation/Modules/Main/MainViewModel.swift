//
//  MainViewModel.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//  
//

import Foundation

final class MainViewModel {

	private let router: MainRouterProtocol
    private let characterUseCase: CharacterUseCaseProtocol

    private var currentPage = 1
    private var hasNewPage = true
    private var charactersList: [CharacterEntity] = []
    var refreshList: (() -> Void)?
    var startActivityIndicator: (() -> Void)?
    var stopActivityIndicator: (() -> Void)?
    var scrollToTop: (() -> Void)?

	required init(router: MainRouterProtocol, characterUseCase: CharacterUseCaseProtocol) {
		self.router = router
        self.characterUseCase = characterUseCase
	}
}

extension MainViewModel: MainViewModelProtocol {

    // MARK: Lifecycle
    func viewReady() {
        fetchCharacters()
    }

    func fetchCharacters() {
        Task {
            if !hasNewPage {
                return
            }
            do {
                self.startActivityIndicator?()
                let charactersList = try await characterUseCase.getCharacterList(page: currentPage)
                if self.currentPage == 1 {
                    self.charactersList.removeAll()
                    self.charactersList.append(contentsOf: charactersList.0)
                    self.scrollToTop?()
                } else {
                    self.charactersList.append(contentsOf: charactersList.0)
                }
                if charactersList.1 {
                    currentPage += 1
                } else {
                    hasNewPage = false
                }
                self.stopActivityIndicator?()
                self.refreshList?()
            } catch {
                throw error
            }
        }
    }

    func resetPagination() {
        currentPage = 1
        hasNewPage = true
    }

    func filterCharacters(name: String) {
        Task {
            if !hasNewPage {
                return
            }
            do {
                self.startActivityIndicator?()
                let charactersList = try await characterUseCase.filterCharacter(name: name, page: currentPage)
                if self.currentPage == 1 {
                    self.charactersList.removeAll()
                    self.charactersList.append(contentsOf: charactersList.0)
                    self.scrollToTop?()
                } else {
                    self.charactersList.append(contentsOf: charactersList.0)
                }
                if charactersList.1 {
                    currentPage += 1
                } else {
                    hasNewPage = false
                }
                self.stopActivityIndicator?()
                self.refreshList?()
            } catch {
                throw error
            }
        }
    }

    var characters: [CharacterEntity] {
        get { charactersList }
        set { charactersList = newValue }
    }

    func showCharacterDetail(characterId: Int) {
        let detailViewController = Container.shared.detailBuilder().build(characterId: characterId)
        router.showDetail(viewController: detailViewController)
    }
}
