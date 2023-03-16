//
//  NetworkError.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 16/3/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}
