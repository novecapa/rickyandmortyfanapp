//
//  CharacterUseCase.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation

protocol CharacterUseCaseProtocol {
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool)
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool)
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?)
}

final class CharacterUseCase {
    let repository: CharacterRepositoryProtocol
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
}

extension CharacterUseCase: CharacterUseCaseProtocol {
    
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool) {
        do {
            let list = try await repository.getCharacterList(page: page)
            return (list.0, list.1)
        } catch {
            throw error
        }
    }
    
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool) {
        do {
            let list = try await repository.filterCharacter(name: name, page: page)
            return (list.0, list.1)
        } catch {
            throw error
        }
    }
    
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?) {
        do {
            let character = try await repository.getCharacterDetail(id: id)
            return character
        } catch {
            throw error
        }
    }
}
