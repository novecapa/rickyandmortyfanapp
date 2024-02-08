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
    func getCharacterList() throws -> ([RCharacter])
    func filterCharacter(name: String) throws -> ([RCharacter])
    func getCharacterDetail(id: Int) throws -> (RCharacter?)
}

final class CharacterRDataClient: CharacterRDataClientProtocol {

    func saveCharacters(characters: [CharacterEntity]) throws {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(characters.map { $0.toRealm }, update: .modified)
            }
        } catch {
            throw error
        }
    }

    func getCharacterList() throws -> ([RCharacter]) {
        do {
            let realm = try Realm()
            return Array(realm.objects(RCharacter.self))
        } catch {
            throw error
        }
    }

    func filterCharacter(name: String) throws -> ([RCharacter]) {
        do {
            let realm = try Realm()
            return Array(realm.objects(RCharacter.self).filter("name LIKE[c] '*\(name)*'"))
        } catch {
            throw error
        }
    }

    func getCharacterDetail(id: Int) throws -> (RCharacter?) {
        do {
            let realm = try Realm()
            return realm.objects(RCharacter.self).filter("id = \(id)").first
        } catch {
            throw error
        }
    }
}
