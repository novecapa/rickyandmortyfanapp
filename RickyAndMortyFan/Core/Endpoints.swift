//
//  Endpoints.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 12/2/24.
//

import Foundation

enum Endpoints {

    static let baseURL = "https://rickandmortyapi.com/api/"

    enum Constants {
        static let character = "character"
        static let page = "page"
        static let name = "name"
    }

    case list(Int)
    case filterCharacter(Int, String)
    case detail(Int)
    var rawValue: String {
        switch self {
        case .list(let page):
            return "\(Constants.character)/?\(Constants.page)=\(page)"
        case .filterCharacter(let page, let name):
            return "\(Constants.character)/?\(Constants.page)=\(page)&\(Constants.name)=\(name)"
        case .detail(let id):
            return "\(Constants.character)/\(id)"
        }
    }
}
