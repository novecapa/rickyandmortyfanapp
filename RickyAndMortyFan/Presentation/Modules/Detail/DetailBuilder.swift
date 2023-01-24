//
//  DetailBuilder.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//  
//

import Foundation
import UIKit

final class DetailBuilder: DetailBuilderProtocol {

    func build(characterId: Int) -> DetailViewController {
        let storyboard = UIStoryboard(name: DetailViewController.identifier, 
									  bundle: Bundle.main)
		let vController = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier)
		if let viewController = vController as? DetailViewController {
			let router = DetailRouter(viewController: viewController)
            let characterRepo = CharacterRepository()
            let characterUseCase = CharacterUseCase(repository: characterRepo)
            let viewModel = DetailViewModel(router: router,
                                            characterUseCase: characterUseCase,
                                            characterId: characterId)

			viewController.viewModel = viewModel

			return viewController
		} else {
			return DetailViewController()
		}
	}
}
