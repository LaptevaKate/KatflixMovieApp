//
//  NetworkManager.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation
import UIKit

class NetworkManager {
    
    static func fetchMovies(completionHandler: @escaping (_ result: Result<PopularMoviesModel, NetworkError>) -> Void) {
        
        if NetworkConstant.apiKey.rawValue.isEmpty {
            completionHandler(.failure(.noApiKey))
            return
        }
        
        let urlString = NetworkConstant.serverAddress.rawValue +
        NetworkConstant.trendingAllDay.rawValue +
        NetworkConstant.apiKey.rawValue
                
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error.debugDescription)
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                guard let data = data else {
                    completionHandler(.failure(.canNoteParseData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let resultData = try decoder.decode(PopularMoviesModel.self, from: data)
                    completionHandler(.success(resultData))
                } catch {
                    completionHandler(.failure(.otherError))
                }
            }
        }.resume()
    }
}
