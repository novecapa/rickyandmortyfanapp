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

final class CharacterNetworkClient: CharacterNetworkClientProtocol {

    let networkClient: NetworkClientProtocol
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
