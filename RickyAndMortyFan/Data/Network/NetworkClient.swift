//
//  NetworkClient.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 8/2/24.
//

import Foundation

protocol NetworkClientProtocol {
    func load<T: Decodable>(urlString: String, of type: T.Type) async throws -> T
}

class NetworkClient: NetworkClientProtocol {
    func load<T: Decodable>(urlString: String, of type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    return try decoder.decode(type, from: data)
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
