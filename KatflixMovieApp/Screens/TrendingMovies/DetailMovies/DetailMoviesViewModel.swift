//
//  DetailMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import Foundation
import UIKit

protocol DetailMoviesDelegate : AnyObject {
    func updateDB()
}

class DetailMoviesViewModel {
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
        
    }
}
