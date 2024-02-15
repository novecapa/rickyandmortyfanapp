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
    // MARK: -
    func fetchCharacters()
    func filterCharacters(name: String)
    func resetPagination()
    var characters: [CharacterEntity] { get }
    // MARK: -
    var refreshList: (() -> Void)? { get set }
    var startActivityIndicator: (() -> Void)? { get set }
    var stopActivityIndicator: (() -> Void)? { get set }
    var scrollToTop: (() -> Void)? { get set }
    // MARK: -
    func showCharacterDetail(characterId: Int)
}

protocol MainRouterProtocol {
    func showDetail(characterId: Int)
}

protocol MainBuilderProtocol {
    func build() -> MainViewController
}
