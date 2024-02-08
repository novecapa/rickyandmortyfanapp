//
//  CharacterRepository.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool)
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool)
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?)
}

final class CharacterRepository {

    let characterNetworkClient: CharacterNetworkClientProtocol
    let characterRDataClient: CharacterRDataClientProtocol

    init(characterNetworkClient: CharacterNetworkClientProtocol,
         characterRDataClient: CharacterRDataClientProtocol) {
        self.characterNetworkClient = characterNetworkClient
        self.characterRDataClient = characterRDataClient
    }
}

extension CharacterRepository: CharacterRepositoryProtocol {

    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool) {
        do {
            if page == 1 && !Utils.hasInternetConnection {
                return (try self.characterRDataClient.getCharacterList().map { $0.toEntity }, false)
            }
            let result = try await self.characterNetworkClient.getCharacterList(page: page)
            let characters = result.results.map { $0.toEntity }

            // Data persistance on DB
            try self.characterRDataClient.saveCharacters(characters: characters)

            return (characters, result.info.hasNextPage)
        } catch {
            throw error
        }
    }

    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool) {
        do {
            if !Utils.hasInternetConnection {
                return (try self.characterRDataClient.filterCharacter(name: name).map { $0.toEntity }, false)
            }
            let result = try await self.characterNetworkClient.filterCharacter(name: name, page: page)
            let characters = result.results.map { $0.toEntity }
            return (characters, result.info.hasNextPage)
        } catch {
            throw error
        }
    }

    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?) {
        do {
            return !Utils.hasInternetConnection
            ? try self.characterRDataClient.getCharacterDetail(id: id)?.toEntity
            : try await self.characterNetworkClient.getCharacterDetail(id: id).toEntity
        } catch {
            throw error
        }
    }
}
