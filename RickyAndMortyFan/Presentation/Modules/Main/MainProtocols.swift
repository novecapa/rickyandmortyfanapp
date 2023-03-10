//
//  MainProtocols.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//  
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    func viewReady()
    func viewDidAppear()
    // MARK: -
    func fetchCharacters()
    func filterCharacters(name: String)
    func resetPagination()
    func getCharacterList() -> [CharacterEntity]
    // MARK: -
    var refreshList: (() -> Void)? { get set }
    var startActivityIndicator: (() -> Void)? { get set }
    var stopActivityIndicator: (() -> Void)? { get set }
    var scrollToTop: (() -> Void)? { get set }
    // MARK: -
    func showCharacterDetail(characterId: Int)
}

protocol MainRouterProtocol {
    func showDetail(viewController: UIViewController)
}

protocol MainBuilderProtocol {
    func build() -> MainViewController
}
