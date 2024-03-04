//
//  DetailMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import UIKit

class DetailMoviesViewController: UIViewController {
    
    weak var delegate: DetailMoviesDelegate?
    private let movieDetailViewModel = DetailMoviesViewModel()
    let movieDetailView = MovieDetailView()
    
    init(movie: MovieModel) {
        movieDetailViewModel.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        movieDetailViewModel.delegate = self
        movieDetailView.delegate = self
        setViewProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        movieDetailView.scrollView.contentSize.height = self.movieDetailView.titleName.bounds.height + self.movieDetailView.overview.bounds.height + self.movieDetailView.addToFavoritesButton.bounds.height + 80
    }
    
    private func setViewProperties() {
        movieDetailView.titleName.text = movieDetailViewModel.movie.title
        movieDetailView.overview.text = movieDetailViewModel.movie.overview
        movieDetailView.voteAverage.text = "Score: \(String(movieDetailViewModel.movie.voteAverage!))"
        movieDetailView.releaseDate.text = "Release Date: \(movieDetailViewModel.movie.releaseDate!)"
        movieDetailViewModel.getBackdropFromURL(backdropPath: movieDetailViewModel.movie.backdropPath!, backdropView: movieDetailView.backdropImage)
    }
}

extension DetailMoviesViewController: DetailMoviesDelegate {
    func updateDB() {
        //        
    }
}
extension DetailMoviesViewController: MovieDetailViewDelegate {
    func didTapFavoriteButton() {
        movieDetailViewModel.didTapAddToFavorites()
    }
}
