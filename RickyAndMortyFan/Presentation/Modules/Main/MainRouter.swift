//
//  MainRouter.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//  
//

import Foundation
import UIKit

final class MainRouter {
	private weak var viewController: UIViewController?
    private let container: Container

	required init(viewController: UIViewController?, container: Container = Container.shared) {
        self.viewController = viewController
        self.container = container
    }
}

extension MainRouter: MainRouterProtocol {
    func showDetail(characterId: Int) {
        DispatchQueue.main.async {
            let detailViewController = self.container.detailBuilder().build(characterId: characterId)
            self.viewController?.present(detailViewController, animated: true)
        }
    }
}
