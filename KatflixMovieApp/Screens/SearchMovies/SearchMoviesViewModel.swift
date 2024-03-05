//
//  SearchMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import Foundation
import UIKit

class SearchMoviesViewModel {
    
    var searchResults: [MovieModel] = []
    var diffableDataSource : UITableViewDiffableDataSource<Section, MovieModel>!
   
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
}
