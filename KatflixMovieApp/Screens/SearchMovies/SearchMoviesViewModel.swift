//
//  SearchMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import UIKit
import RealmSwift

class SearchMoviesViewModel {
    
    let realm = try! Realm()
    var searchResults: [MovieModel] = []
    var diffableDataSource : UITableViewDiffableDataSource<Section, MovieModel>!
    
    var tableCell = SearchMovieCustomCell()
    var searchController = UISearchController(searchResultsController: nil)
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
        snapshot.appendSections([.search])
        snapshot.appendItems(self.searchResults)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func getSearchResults(query: String, page: Int) {
        let trimmedString = query.replacingOccurrences(of: " ", with: "%20")
        NetworkManager.shared.getSearchResults(query: trimmedString, page: page) { result in
            switch result {
            case .success(let searchResults):
                self.searchResults = searchResults.results
                print(searchResults)
                self.applySnapshot()
            case .failure(let error):
                print(error)
            }
        }
    }
    func getTitleForItem(item: MovieModel, cell: SearchMovieCustomCell) {
        if let title = item.title {
            cell.titleLabel.text = title
        } else {
            cell.titleLabel.text = "Not Found"
        }
    }
    func getPosterForItem(item: MovieModel, cell: SearchMovieCustomCell) {
        if let posterPath = item.posterPath {
            cell.getPosterFromURL(posterPath: posterPath)
        } else {
            cell.poster.image = UIImage(named: "poster-placeholder")
        }
    }
    func formatReleaseDate(item: MovieModel, cell: SearchMovieCustomCell) {
        if let releaseDate = item.releaseDate {
            cell.releaseDate.text = "\(releaseDate.components(separatedBy: "-")[0])"
        } else {
            cell.releaseDate.text = "Unknown Date"
        }
    }
    func displayVoteAverage(item: MovieModel, cell: SearchMovieCustomCell) {
        if let voteAverage = item.voteAverage {
            cell.voteAverage.text = String(voteAverage)
        } else {
            cell.voteAverage.text = "?.?"
        }
    }
    
    func checkForFavorite(item: MovieModel, cell: SearchMovieCustomCell){ if (self.realm.object(ofType: RealmMovieModel.self, forPrimaryKey: item.id) == nil) {
        cell.alreadyFavoritedButton.isHidden = true
    } else {
        cell.alreadyFavoritedButton.isHidden = false
    }
    }
    
    func identifyVoteSymbol(item: MovieModel, cell: SearchMovieCustomCell){
        if let voteAverage = item.voteAverage, voteAverage < 4.0 {
            cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        } else if let voteAverage = item.voteAverage, voteAverage < 7.0 {
            cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        } else if let voteAverage = item.voteAverage, voteAverage < 8.0 {
            cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        }
    }
    
}
