//
//  TrendingViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import Foundation
import UIKit

protocol TrendingViewModelDelegate: AnyObject {
    func didFetchMovieDetails()
}

final class TrendingViewModel {
    
    weak var delegate: TrendingViewModelDelegate?
    
    var trendingMovies: [MovieModel] = []
    var diffableDataSource : UITableViewDiffableDataSource<Section, MovieModel>!
    
    func voteAverageColorCheck(voteAverage: Double) -> UIColor {
        if voteAverage < 4.0 {
            return .systemRed
        } else if voteAverage < 7.0 {
            return .systemOrange
        } else if voteAverage < 8.0 {
            return .systemYellow
        } else {
            return .systemGreen
        }
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
        snapshot.appendSections([.trendingSection])
        snapshot.appendItems(self.trendingMovies)
        self.diffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func getTrendingMovies() {
        NetworkManager.shared.getTrendingMovies(contentType: .movie, timePeriod: .week) { result in
            switch result {
            case .success(let movies):
                self.trendingMovies = movies.results
                                self.updateDataSource()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapMovieCell(movieID: Int) {
        fetchMovieDetails(movieID: movieID)
    }
    
    func fetchMovieDetails(movieID: Int) {
        NetworkManager.shared.getMovieByID(movieID: movieID) { result in
            switch result {
            case .success(_):
                self.delegate?.didFetchMovieDetails()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func applyChangesToSnapshot() {
        var snapshot = diffableDataSource.snapshot()
        snapshot.reloadItems(self.trendingMovies)
        diffableDataSource.applySnapshotUsingReloadData(snapshot)
        print("refreshing diff db")
    }
    
    
}
