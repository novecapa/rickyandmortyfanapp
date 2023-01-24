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

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension MainRouter: MainRouterProtocol {
    func showDetail(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.viewController?.present(viewController, animated: true)
        }
    }
}
