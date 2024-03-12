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
    
    func getTrendingMovies(contentType mediatype: trendingMediaType, timePeriod timeWindow: trendingTimeWindow, completion: @escaping (Swift.Result<PopularMoviesModel, NetworkError>) -> Void) {
        
        let endpoint = "\(NetworkConstant.baseURL.rawValue)/trending/\(mediatype)/\(timeWindow)?api_key=\(NetworkConstant.apiKey.rawValue)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error  {
                completion(.failure(.networkError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unexpectedResponse))
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(PopularMoviesModel.self, from: data)
                completion(.success(movies))
            } catch {
                return
            }
        }
        task.resume()
    }
    
    func getMovieByID(movieID id: Int, completion: @escaping (Swift.Result<MovieModel, NetworkError>) -> Void) {
        
        let endpoint = "\(NetworkConstant.baseURL.rawValue)/movie/\(id)?api_key=\(NetworkConstant.apiKey.rawValue)"
        guard let url = URL(string: endpoint) else { 
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error  {
                completion(.failure(.networkError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { 
                completion(.failure(.unexpectedResponse))
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieModel.self, from: data)
                completion(.success(movie))
            } catch {
                return
            }
        }
        task.resume()
    }
    
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
    
    func getSearchResults(query: String, page: Int, completion: @escaping (Swift.Result<PopularMoviesModel, NetworkError>) -> Void) {
        
        let endpoint = "\(NetworkConstant.baseURL.rawValue)/search/movie?api_key=\(NetworkConstant.apiKey.rawValue)&language=en-US&query=\(query)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error  {
                completion(.failure(.networkError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { 
                completion(.failure(.unexpectedResponse))
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(PopularMoviesModel.self, from: data)
                completion(.success(searchResult))
            } catch {
                return
            }
        }
        task.resume()
    }
}
