//
//  DetailProtocols.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//  
//

import Foundation

protocol DetailViewModelProtocol {
    func viewReady()
    // MARK: -
    var character: CharacterEntity? { get }
    // MARK: -
    var refresh: (() -> Void)? { get set }
    var startActivityIndicator: (() -> Void)? { get set }
    var stopActivityIndicator: (() -> Void)? { get set }
}

protocol DetailRouterProtocol {}

protocol DetailBuilderProtocol {
    func build(characterId: Int) -> DetailViewController
}
