//
//  PopularMoviesModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation

struct PopularMoviesModel: Codable, Hashable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
