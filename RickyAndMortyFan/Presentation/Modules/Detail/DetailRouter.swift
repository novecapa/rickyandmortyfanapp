//
//  DetailRouter.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//  
//

import Foundation
import UIKit

final class DetailRouter {
	private weak var viewController: UIViewController?

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension DetailRouter: DetailRouterProtocol { }
