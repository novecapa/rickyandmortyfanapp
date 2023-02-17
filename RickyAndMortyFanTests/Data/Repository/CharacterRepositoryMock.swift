//
//  CharacterRepositoryMock.swift
//  RickyAndMortyFanTests
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//

import XCTest
@testable import RickyAndMortyFan

final class CharacterRepositoryMock: CharacterRepositoryProtocol {

    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool) {
        return (CharacterEntityMock.getListMock(), false)
    }
    func filterCharacter(name: String,
                         page: Int) async throws ->  ([CharacterEntity], Bool) {
        return (CharacterEntityMock.getListMock(), false)
    }
    
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity) {
        return CharacterEntityMock.getListMock().first ?? CharacterEntity(id: -1,
                                                                          name: "Unknow",
                                                                          status: "Unknow",
                                                                          image: "Unknow",
                                                                          location: "Unknow",
                                                                          episode: [""])
    }
    
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity?) {
        return CharacterEntityMock.getListMock().first
    }
}
