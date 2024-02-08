//
//  CharacterEntity.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation
import UIKit

struct CharacterEntity {

    private enum Constants {
        static let alive = "alive"
        static let dead = "dead"
    }

    let id: Int
    let name: String
    let status: String
    let image: String
    let location: String
    let episode: [String]
}

extension CharacterEntity {
    var isAlive: String {
        switch status.lowercased() {
        case Constants.alive:
            return "🙂"
        case Constants.dead:
            return "☠️"
        default:
            return "😶‍🌫️"
        }
    }
}

extension CharacterEntity {
    var toRealm: RCharacter {
        RCharacter(id: self.id,
                   name: self.name,
                   status: self.status,
                   image: self.image,
                   location: self.location,
                   episode: self.episode.map { $0 })
    }
}
