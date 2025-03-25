//
//  Networking.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation

struct Networking {
    /// Sends an asynchronous GET request to the specified URL string and decodes the response into the given Decodable type.
    ///
    /// - Parameters:
    ///   - urlString: A string representation of the URL to request.
    ///   - type: The expected type to decode the response into.
    /// - Returns: An instance of the decoded type `T`.
    /// - Throws:
    ///   - `APIError.invalidURL` if the URL string is malformed.
    ///   - `APIError.decodingError` if the response fails to decode.
    ///   - `APIError.networkError` for other networking-related issues.
    ///
    /// - Note: This function uses `URLSession.shared` and is intended for JSON-based APIs.
    static func request<T: Decodable>(
        urlString: String,
        type: T.Type
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
}
