//
//  DetailMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import UIKit

protocol DetailMoviesDelegate : AnyObject {
    func updateRealmDataBase()
}

final class DetailMoviesViewController: UIViewController {
    
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
        guard let movieVote = movieDetailViewModel.movie.voteAverage else {return }
        movieDetailView.voteAverage.text = NSLocalizedString("scoreTextDetailVC", comment: "") + String(movieVote)
        guard let movieReleaseDate = movieDetailViewModel.movie.releaseDate else {return }
        movieDetailView.releaseDate.text = NSLocalizedString("releaseDateTextDetailVC", comment: "") + movieReleaseDate
        guard let movieBackdropPath = movieDetailViewModel.movie.backdropPath else {return }
        movieDetailViewModel.getBackdropFromURL(backdropPath: movieBackdropPath, backdropView: movieDetailView.backdropImage)
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: NSLocalizedString("alertTitleDetailVC", comment: ""),
                                      message: NSLocalizedString("alertMessageDetailVC", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alertOKDetailVC", comment: ""), 
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailMoviesViewController: DetailMoviesDelegate {
    func updateRealmDataBase() {       
    }
}

extension DetailMoviesViewController: MovieDetailViewDelegate {
    func didTapFavoriteButton() {
        movieDetailViewModel.didTapAddToFavorites()
        presentAlert()
    }
}
