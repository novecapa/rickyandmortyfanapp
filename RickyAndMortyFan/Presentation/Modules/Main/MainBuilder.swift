//
//  MainBuilder.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//  
//

import Foundation
import UIKit

final class MainBuilder: MainBuilderProtocol {

	func build() -> MainViewController {
        let storyboard = UIStoryboard(name: MainViewController.identifier,
									  bundle: Bundle.main)
		let vController = storyboard.instantiateViewController(withIdentifier: MainViewController.identifier)
		if let viewController = vController as? MainViewController {
			let router = MainRouter(viewController: viewController)
            let characterRepo = CharacterRepository(characterNetworkClient: CharacterNetworkClient(),
                                                    characterRDataClient: CharacterRDataClient())
            let characterUseCase = CharacterUseCase(repository: characterRepo)
			let viewModel = MainViewModel(router: router, characterUseCase: characterUseCase)

			viewController.viewModel = viewModel

			return viewController
		} else {
			return MainViewController()
		}
	}
}
