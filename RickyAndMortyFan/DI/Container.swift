//
//  Container.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation
import UIKit

class Container {

    static let shared = Container()

    weak var window: UIWindow?
    weak var homeViewController: UIViewController?
}
