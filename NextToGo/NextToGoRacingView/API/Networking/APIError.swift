//
//  APIError.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

enum APIError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
    case unknown
}
