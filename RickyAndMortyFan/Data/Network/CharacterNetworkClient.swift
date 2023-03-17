//
//  CharacterNetworkClient.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 15/2/23.
//

import Foundation

protocol CharacterNetworkClientProtocol {
    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool)
    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool)
    func getCharacterDetail(id: Int) async throws -> (CharacterEntity)
}

final class CharacterNetworkClient: CharacterNetworkClientProtocol {

    final let baseURL = "https://rickandmortyapi.com/api/"

    func getCharacterList(page: Int) async throws -> ([CharacterEntity], Bool) {
        guard let url = URL(string: "\(baseURL)character/?page=\(page)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
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
                    return (characList, hasNextPage)
                } else {
                    throw NetworkError.badResponse
                }
            } catch {
                throw NetworkError.decodeError
            }
        } catch {
            throw NetworkError.badRequest
        }
    }

    func filterCharacter(name: String, page: Int) async throws -> ([CharacterEntity], Bool) {
        guard let url = URL(string: "\(baseURL)character/?page=\(page)&name=\(name)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
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
                    throw NetworkError.badResponse
                }
            } catch {
                throw NetworkError.decodeError
            }
        } catch {
            throw NetworkError.badRequest
        }
    }

    func getCharacterDetail(id: Int) async throws -> (CharacterEntity) {
        guard let url = URL(string: "\(baseURL)character/\(id)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    let result = try decoder.decode(CharacterDTO.self, from: data)
                    return result.toEntity
                } else {
                    throw NetworkError.badResponse
                }
            } catch {
                throw NetworkError.decodeError
            }
        } catch {
            throw NetworkError.badRequest
        }
    }
}
