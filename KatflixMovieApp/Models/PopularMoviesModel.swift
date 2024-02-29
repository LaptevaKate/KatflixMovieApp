//
//  PopularMoviesModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation

struct PopularMoviesModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
}
