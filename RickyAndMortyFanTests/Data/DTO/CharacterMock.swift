//
//  CharacterEntity.swift
//  RickyAndMortyFanTests
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//

import XCTest
@testable import RickyAndMortyFan

final class CharacterEntityMock {
    
    static func getListMock() -> [CharacterEntity] {
        
        return [CharacterEntity(id: 1,
                                name: "name1",
                                status: "status",
                                image: "urlImage",
                                location: "location",
                                episode: ["ep1", "ep2"])]
    }
}
