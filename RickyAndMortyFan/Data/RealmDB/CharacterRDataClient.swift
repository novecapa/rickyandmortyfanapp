//
//  CharacterRDataClient.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 15/2/23.
//

import Foundation
import RealmSwift

protocol CharacterRDataClientProtocol {
    func saveCharacters(characters: [CharacterEntity]) throws
    func getCharacterList() throws -> ([CharacterEntity])
    func filterCharacter(name: String) throws -> ([CharacterEntity])
    func getCharacterDetail(id: Int) throws -> (CharacterEntity?)
}

final class CharacterRDataClient: CharacterRDataClientProtocol {
    
    func saveCharacters(characters: [CharacterEntity]) throws {
        do {
            let realm = try Realm()
            var newCharacters:[RCharacter] = []
            characters.forEach { cha in
                newCharacters.append(RCharacter(id: cha.id,
                                                name: cha.name,
                                                status: cha.status,
                                                image: cha.image,
                                                location: cha.location,
                                                episode: cha.episode.map { $0 }))
            }
            try realm.write {
                realm.add(newCharacters, update: .modified)
            }
        } catch {
            throw error
        }
    }
    
    func getCharacterList() throws -> ([CharacterEntity]) {
        do {
            var characters:[CharacterEntity] = []
            let realm = try Realm()
            let rcharacters = Array(realm.objects(RCharacter.self))
            rcharacters.forEach { rchar in
                characters.append(rchar.toEntity)
            }
            return characters
        } catch {
            throw error
        }
    }
    
    func filterCharacter(name: String) throws -> ([CharacterEntity]) {
        do {
            var characters:[CharacterEntity] = []
            let realm = try Realm()
            let rcharacters = Array(realm.objects(RCharacter.self).filter("name LIKE[c] '*\(name)*'"))
            rcharacters.forEach { rchar in
                characters.append(rchar.toEntity)
            }
            return characters
        } catch {
            throw error
        }
    }
    
    func getCharacterDetail(id: Int) throws -> (CharacterEntity?) {
        do {
            let realm = try Realm()
            let rcharacter = realm.objects(RCharacter.self).filter("id = \(id)").first
            return rcharacter?.toEntity
        } catch {
            throw error
        }
    }
}
