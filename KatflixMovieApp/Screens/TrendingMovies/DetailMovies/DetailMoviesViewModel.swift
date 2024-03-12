//
//  DetailMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import Foundation
import UIKit
import RealmSwift

class DetailMoviesViewModel {
    
    let realm = try! Realm()
    weak var delegate: DetailMoviesDelegate?
    var movie: MovieModel!
    
    func getBackdropFromURL(backdropPath: String, backdropView: UIImageView) {
        NetworkManager.shared.getBackdropImage(backdropPath: backdropPath) { image in
            DispatchQueue.main.async {
                backdropView.image = image
            }
        }
    }
    
    func didTapAddToFavorites() {
        try! realm.write({
            let movie = RealmMovieModel()
            movie.title = self.movie.title!
            movie.id = self.movie.id
            movie.poster = self.movie.posterPath!
            realm.add(movie, update: .modified)
            print("Name: \(movie.title) ID: \(movie.id) || Added to realm")
        })
        self.delegate?.updateRealmDataBase()
        
    }
    
}

