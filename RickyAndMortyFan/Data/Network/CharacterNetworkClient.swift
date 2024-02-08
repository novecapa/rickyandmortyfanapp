//
//  CharacterNetworkClient.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 15/2/23.
//

import Foundation

protocol CharacterNetworkClientProtocol {
    func getCharacterList(page: Int) async throws -> CharactersDTO
    func filterCharacter(name: String, page: Int) async throws -> CharactersDTO
    func getCharacterDetail(id: Int) async throws -> CharacterDTO
}

private enum Endpoints {

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

final class CharacterNetworkClient: CharacterNetworkClientProtocol {

    let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }

    func getCharacterList(page: Int) async throws -> CharactersDTO {
        do {
            let url = Endpoints.baseURL + Endpoints.list(page).rawValue
            return try await networkClient.load(urlString: url, of: CharactersDTO.self)
        } catch {
            throw error
        }
    }

    func filterCharacter(name: String, page: Int) async throws -> CharactersDTO {
        do {
            let url = Endpoints.baseURL + Endpoints.filterCharacter(page, name).rawValue
            return try await networkClient.load(urlString: url, of: CharactersDTO.self)
        } catch {
            throw error
        }
    }

    func getCharacterDetail(id: Int) async throws -> CharacterDTO {
        do {
            let url = Endpoints.baseURL + Endpoints.detail(id).rawValue
            return try await networkClient.load(urlString: url, of: CharacterDTO.self)
        } catch {
            throw error
        }
    }
}
