//
//  MovieModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation

struct MovieModel: Codable, Hashable {
    
    let id: Int
    let title: String?
    let name: String?
    let originalTitle: String?
    let originalName: String?
    let overview: String
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let adult: Bool?
    let video: Bool?
    let voteCount: Int?
    let voteAverage: Double?
    let mediaType: MediaType?
    
    
    enum MediaType: String, Codable {
        case movie = "movie"
        case tv = "tv"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case name = "name"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case video = "video"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case mediaType = "media_type"
    }
}
