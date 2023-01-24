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
    
    static func saveCharacters(characters: [CharacterEntity]) {
        DispatchQueue.global(qos:.background).async {
            if let realm = try? Realm() {
                var newCharacters:[RCharacter] = []
                characters.forEach { cha in
                    newCharacters.append(RCharacter(id: cha.id,
                                                    name: cha.name,
                                                    status: cha.status,
                                                    image: cha.image,
                                                    location: cha.location,
                                                    episode: cha.episode.map { $0 }))
                }
                try? realm.write {
                    realm.add(newCharacters, update: .modified)
                }
            }
//                DispatchQueue.main.async {
//                    completion(successBool, errorMsg)
//                }
        }
    }
    
    static func getAllCharacters() -> [CharacterEntity] {
        var characters:[CharacterEntity] = []
        if let realm = try? Realm() {
            let rcharacters = Array(realm.objects(RCharacter.self))
            rcharacters.forEach { rchar in
                characters.append(rchar.toEntity)
            }
            return characters
        } else {
            return []
        }
    }
    
    static func filterCharacter(name: String) -> [CharacterEntity] {
        var characters:[CharacterEntity] = []
        if let realm = try? Realm() {
            let rcharacters = Array(realm.objects(RCharacter.self).filter("name LIKE[c] '*\(name)*'"))
            rcharacters.forEach { rchar in
                characters.append(rchar.toEntity)
            }
            return characters
        } else {
            return []
        }
    }
    
    static func getCharacterDetail(id: Int) -> CharacterEntity? {
        if let realm = try? Realm() {
            let rcharacter = realm.objects(RCharacter.self).filter("id = \(id)").first
            return rcharacter?.toEntity
        } else {
            return nil
        }
    }
    
    var toEntity: CharacterEntity {
        return CharacterEntity(id: self.id,
                               name: self.name,
                               status: self.status,
                               image: self.image,
                               location: self.location,
                               episode: self.episode.map { $0 })
    }
}
