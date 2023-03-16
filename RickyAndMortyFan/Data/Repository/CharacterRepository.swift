//
//  CharacterRepository.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool)
    func filterCharacter(name: String, page: Int) async throws ->  ([CharacterEntity], Bool)
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
        if page == 1 && !Utils.existsConnection() {
            do {
                return (try self.characterRDataClient.getCharacterList(), false)
            } catch {
                throw error
            }
        }
        do {
            let list = try await self.characterNetworkClient.getCharacterList(page: page)
            try self.characterRDataClient.saveCharacters(characters: list.0)
            return (list)
        } catch {
            throw error
        }
    }
    
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool) {
        if !Utils.existsConnection() {
            do {
                return (try self.characterRDataClient.filterCharacter(name: name), false)
            } catch {
                throw error
            }
        }
        do {
            return (try await self.characterNetworkClient.filterCharacter(name: name, page: page))
        } catch {
            throw error
        }
    }
    
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?) {
        if !Utils.existsConnection() {
            do {
                return try self.characterRDataClient.getCharacterDetail(id: id)
            } catch {
                throw error
            }
        }
        do {
            return try await self.characterNetworkClient.getCharacterDetail(id: id)
        } catch {
            throw error
        }
    }
}
