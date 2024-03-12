//
//  NetworkError.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 11.03.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case unexpectedResponse
    case networkError(Error)
    case decodingError(Error)
    case serverError(statusCode: Int)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .unexpectedResponse:
            return "The server response was not in the expected format."
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        }
    }
}
