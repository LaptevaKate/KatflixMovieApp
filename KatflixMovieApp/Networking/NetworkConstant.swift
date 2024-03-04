//
//  NetworkConstant.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation

enum NetworkConstant: String {
    case apiKey = "efd37a90c8b1d6119c66261669ea744d"
    case baseURL = "https://api.themoviedb.org/3"
    case imgBaseURL = "https://image.tmdb.org/t/p/original/"
}

enum trendingMediaType : String {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}
 
enum trendingTimeWindow : String {
    case day = "day"
    case week = "week"
}
