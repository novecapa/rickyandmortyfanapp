//
//  CharactersDTO.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation

// MARK: - CharactersDTO
struct CharactersDTO: Codable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

// MARK: - Info
struct InfoDTO: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let location: LocationDTO
    let episode: [String]
}

struct LocationDTO: Codable {
    let name: String
    let url: String
}

extension CharacterDTO {
    var toEntity: CharacterEntity {
        return CharacterEntity(id: self.id,
                               name: self.name,
                               status: self.status,
                               image: self.image,
                               location: self.location.name,
                               episode: self.episode.map { $0 })
    }
}

