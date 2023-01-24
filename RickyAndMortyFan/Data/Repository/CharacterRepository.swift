//
//  CharacterRepository.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import Foundation

enum CharacterRepositoryError: Error{
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}

protocol CharacterRepositoryProtocol {
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool)
    func filterCharacter(name: String, page: Int) async throws ->  ([CharacterEntity], Bool)
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity)
}

final class CharacterRepository: CharacterRepositoryProtocol {
    
    final let baseURL = "https://rickandmortyapi.com/api/"
    
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool) {
        if page == 1 && !Utils.existsConnection() {
            return (RCharacter.getAllCharacters(), false)
        }
        guard let url = URL(string: "\(baseURL)character/?page=\(page)") else {
            throw CharacterRepositoryError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw CharacterRepositoryError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    let result = try decoder.decode(CharactersDTO.self, from: data)
                    var hasNextPage = false
                    guard let nextPage = result.info.next else {
                        hasNextPage = false
                        return (result.results.map { $0.toEntity }, hasNextPage)
                    }
                    hasNextPage = !nextPage.isEmpty ? true : false
                    let characList = result.results.map { $0.toEntity }
                    RCharacter.saveCharacters(characters: characList)
                    return (characList, hasNextPage)
                } else {
                    throw CharacterRepositoryError.badResponse
                }
            } catch {
                throw CharacterRepositoryError.decodeError
            }
        } catch {
            throw CharacterRepositoryError.badRequest
        }
    }
    
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool) {
        if !Utils.existsConnection() {
            return (RCharacter.filterCharacter(name: name), false)
        }
        guard let url = URL(string: "\(baseURL)character/?page=\(page)&name=\(name)") else {
            throw CharacterRepositoryError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw CharacterRepositoryError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    let result = try decoder.decode(CharactersDTO.self, from: data)
                    var hasNextPage = false
                    guard let nextPage = result.info.next else {
                        hasNextPage = false
                        return (result.results.map { $0.toEntity }, hasNextPage)
                    }
                    hasNextPage = !nextPage.isEmpty ? true : false
                    return (result.results.map { $0.toEntity }, hasNextPage)
                } else {
                    throw CharacterRepositoryError.badResponse
                }
            } catch {
                throw CharacterRepositoryError.decodeError
            }
        } catch {
            throw CharacterRepositoryError.badRequest
        }
    }
    
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity) {
        if !Utils.existsConnection() {
            return RCharacter.getCharacterDetail(id: id) ?? CharacterEntity(id: -1,
                                                                            name: "Unknow",
                                                                            status: "Unknow",
                                                                            image: "Unknow",
                                                                            location: "Unknow",
                                                                            episode: [""])
        }
        guard let url = URL(string: "\(baseURL)character/\(id)") else {
            throw CharacterRepositoryError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw CharacterRepositoryError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    let result = try decoder.decode(CharacterDTO.self, from: data)
                    return result.toEntity
                } else {
                    throw CharacterRepositoryError.badResponse
                }
            } catch {
                throw CharacterRepositoryError.decodeError
            }
        } catch {
            throw CharacterRepositoryError.badRequest
        }
    }
}
