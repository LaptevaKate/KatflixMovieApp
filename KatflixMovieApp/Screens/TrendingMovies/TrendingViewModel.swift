//
//  TrendingViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 28.02.24.
//

import UIKit
import RealmSwift

protocol TrendingViewModelDelegate: AnyObject {
    func didFetchMovieDetails()
}

final class TrendingViewModel {
    // MARK: properties
    let realm = try! Realm()
    weak var delegate: TrendingViewModelDelegate?
    var trendingMovies: [MovieModel] = []
    var diffableDataSource : UITableViewDiffableDataSource<Section, MovieModel>!
    // MARK: private methods
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
        snapshot.appendSections([.trending])
        snapshot.appendItems(self.trendingMovies)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }
    // MARK: methods
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
    func getTrendingMovies() {
        NetworkManager.shared.getTrendingMovies(contentType: .movie, timePeriod: .week) { result in
            switch result {
            case .success(let movies):
                self.trendingMovies = movies.results
                self.updateDataSource()
            case .failure(let error):
                print(error.localizedDescription)
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
                print(error.localizedDescription)
            }
        }
    }
    func applyChangesToSnapshot() {
        var snapshot = diffableDataSource.snapshot()
        snapshot.reloadItems(self.trendingMovies)
        diffableDataSource.applySnapshotUsingReloadData(snapshot)
        print("refreshing diff db")
    }
    func getPosterFromURL(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        NetworkManager.shared.getPosterImage(posterPath: posterPath) { image in
            completion(image)
        }
    }
    func isAlreadyInFavorites(id: Int) -> Bool {
        return realm.object(ofType: RealmMovieModel.self, forPrimaryKey: id) == nil
    }
    func checkFavorite(id: Int) -> Bool {
        return realm.object(ofType: RealmMovieModel.self, forPrimaryKey: id) != nil
    }
}
