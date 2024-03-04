//
//  NetworkManager.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTrendingMovies(contentType mediatype: trendingMediaType, timePeriod timeWindow: trendingTimeWindow, completed: @escaping (Swift.Result<PopularMoviesModel, Error>) -> Void) {
        
        let endpoint = "\(NetworkConstant.baseURL.rawValue)/trending/\(mediatype)/\(timeWindow)?api_key=\(NetworkConstant.apiKey.rawValue)"
        
        guard let url = URL(string: endpoint) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(PopularMoviesModel.self, from: data)
                completed(.success(movies))
            } catch {
                return
            }
        }
        task.resume()
    }
    
    func getMovieByID(movieID id: Int, completed: @escaping (Swift.Result<MovieModel, Error>) -> Void) {
        
        let endpoint = "\(NetworkConstant.baseURL.rawValue)/movie/\(id)?api_key=\(NetworkConstant.apiKey.rawValue)"
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieModel.self, from: data)
                completed(.success(movie))
            } catch {
                return
            }
        }
        task.resume()
    }
    
    // GET Poster image for a movie with posterPath
    func getPosterImage(posterPath: String, completion: @escaping (UIImage) -> ()) {
        
        let url: String = NetworkConstant.imgBaseURL.rawValue + posterPath
        
        guard let url = URL(string: url) else {
            return
        }
        
        let img = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            completion(UIImage(data: data)!)
        }
        img.resume()
    }
    
    // GET Backdrop image for a movie with backdropPath
    func getBackdropImage(backdropPath: String, completion: @escaping (UIImage) -> ()) {
        
        let url: String = NetworkConstant.imgBaseURL.rawValue + backdropPath
        
        guard let url = URL(string: url) else {
            return
        }
        
        let img = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            completion(UIImage(data: data)!)
        }
        img.resume()
    }

}
