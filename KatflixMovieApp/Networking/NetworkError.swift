//
//  NetworkError.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import Foundation

enum NetworkError: Error {
    case noApiKey
    case urlError
    case canNoteParseData
    case otherError
}
