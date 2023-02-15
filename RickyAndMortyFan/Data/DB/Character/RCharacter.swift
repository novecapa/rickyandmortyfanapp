//
//  RCharacter.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation
import RealmSwift

class RCharacter: Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var location: String = ""
    var episode = List<String>()
    
    convenience init(id: Int,
                     name: String,
                     status: String,
                     image: String,
                     location: String,
                     episode: [String]) {
        self.init()
        self.id = id
        self.name = name
        self.status = status
        self.image = image
        self.location = location
        self.episode.append(objectsIn: episode)
    }
    
    public override static func primaryKey() -> String {
        return "id"
    }
}

extension RCharacter {
    var toEntity: CharacterEntity {
        return CharacterEntity(id: self.id,
                               name: self.name,
                               status: self.status,
                               image: self.image,
                               location: self.location,
                               episode: self.episode.map { $0 })
    }
}
