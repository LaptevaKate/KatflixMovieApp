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
    


//    func makeMovieModel(with model: MovieModel) -> MovieModel {
//        if model.title != nil {
//            let title = model.title
//        } else {
//            let title  = "Not Found"
//        }
//        
//        if model.posterPath != nil {
//            getPosterFromURL(posterPath: model.posterPath!)
//        } else {
//            let poster = UIImage(named: "poster-placeholder")
//        }
//       
//        if model.releaseDate != nil {
//            let releaseDate = "\(model.releaseDate!.components(separatedBy: "-")[0])"
//        } else {
//            let releaseDate = "Unknown Date"
//        }
//      
//        if model.voteAverage != nil {
//            let voteAverage = String(model.voteAverage!)
//        } else {
//            let voteAverage = "?.?"
//        }
//    
//        if (self.realm.object(ofType: RealmMovieModel.self, forPrimaryKey: model.id) == nil) {
//            tableCell.alreadyFavoritedButton.isHidden = true
//        } else {
//            tableCell.alreadyFavoritedButton.isHidden = false
//        }
//        if model.voteAverage! < 4.0 {
//            let voteSymbol = UIImage(systemName: "heart.square")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//        } else if model.voteAverage! < 7.0 {
//            let voteSymbol = UIImage(systemName: "heart.square")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
//        } else if model.voteAverage! < 8.0 {
//            let voteSymbol = UIImage(systemName: "heart.square")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
//        } else {
//            let voteSymbol = UIImage(systemName: "heart.square")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
//        }
//       return MovieModel(id: <#T##Int#>,
//                         title: <#T##String?#>,
//                         name: <#T##String?#>,
//                         originalTitle: <#T##String?#>,
//                         originalName: <#T##String?#>,
//                         overview: <#T##String#>,
//                         releaseDate: <#T##String?#>,
//                         posterPath: <#T##String?#>,
//                         backdropPath: <#T##String?#>,
//                         adult: <#T##Bool?#>,
//                         video: <#T##Bool?#>,
//                         voteCount: <#T##Int?#>,
//                         voteAverage: <#T##Double?#>,
//                         mediaType: <#T##MovieModel.MediaType?#>)
//    }
}
