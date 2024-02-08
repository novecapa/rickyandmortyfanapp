//
//  DetailViewModel.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//  
//

import Foundation

final class DetailViewModel {

	private let router: DetailRouterProtocol
    private let characterUseCase: CharacterUseCaseProtocol
    private let characterId: Int

    private var characterDetail: CharacterEntity?
    var refresh: (() -> Void)?
    var startActivityIndicator: (() -> Void)?
    var stopActivityIndicator: (() -> Void)?

	required init(router: DetailRouterProtocol, characterUseCase: CharacterUseCaseProtocol, characterId: Int) {
		self.router = router
        self.characterUseCase = characterUseCase
        self.characterId = characterId
	}
}

extension DetailViewModel: DetailViewModelProtocol {

    func viewReady() {
        Task {
            do {
                self.characterDetail = try await characterUseCase.getCharacterDetail(id: self.characterId)
                self.refresh?()
            } catch {
                throw error
            }
        }
    }

    var character: CharacterEntity? {
        return characterDetail
    }
}
