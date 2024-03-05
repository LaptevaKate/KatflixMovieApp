//
//  SearchMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import UIKit
import RealmSwift

class SearchMoviesViewController: UIViewController {
    
    let realm = try! Realm()
    var searchQuery: String?
    var searchTableView = UITableView()
    private let searchViewModel = SearchMoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
    }
}

extension SearchMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableView.deselectRow(at: indexPath, animated: true)
        guard let selectedItem = searchViewModel.diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        navigationController?.pushViewController(DetailMoviesViewController(movie: selectedItem), animated: true)
    }
    private func configureTableView() {
        searchViewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: searchTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = self.searchTableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchMovieCustomCell
            cell.backgroundColor = .black
            if itemIdentifier.title != nil {
                cell.titleLabel.text = itemIdentifier.title
            } else {
                cell.titleLabel.text = "Not Found"
            }
            
            if itemIdentifier.posterPath != nil {
                cell.getPosterFromURL(posterPath: itemIdentifier.posterPath!)
            } else {
                cell.poster.image = UIImage(named: "poster-placeholder")
            }
           
            if itemIdentifier.releaseDate != nil {
                cell.releaseDate.text = "\(itemIdentifier.releaseDate!.components(separatedBy: "-")[0])"
            } else {
                cell.releaseDate.text = "Unknown Date"
            }
          
            if itemIdentifier.voteAverage != nil {
                cell.voteAverage.text = String(itemIdentifier.voteAverage!)
            } else {
                cell.voteAverage.text = "?.?"
            }
        
            if (self.realm.object(ofType: RealmMovieModel.self, forPrimaryKey: itemIdentifier.id) == nil) {
                cell.alreadyFavoritedButton.isHidden = true
            } else {
                cell.alreadyFavoritedButton.isHidden = false
            }
            if itemIdentifier.voteAverage! < 4.0 {
                cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            } else if itemIdentifier.voteAverage! < 7.0 {
                cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            } else if itemIdentifier.voteAverage! < 8.0 {
                cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            } else {
                cell.voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            }
            return cell
        })
        searchTableView.rowHeight = 130
        searchTableView.delegate = self
        searchTableView.register(SearchMovieCustomCell.self, forCellReuseIdentifier: "searchCell")
        searchTableView.frame = view.bounds
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.backgroundColor = .black
        view.addSubview(searchTableView)
    }
}
extension SearchMoviesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchQuery = searchController.searchBar.text ?? ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("didEndEditing")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("buttonClicked")
        searchViewModel.getSearchResults(query: searchQuery ?? "", page: 1)
    }
    
    private func configureSearchController() {
        searchViewModel.searchController.searchResultsUpdater = self
        searchViewModel.searchController.obscuresBackgroundDuringPresentation = false
        searchViewModel.searchController.searchBar.enablesReturnKeyAutomatically = true
        searchViewModel.searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search Movies", attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray3])
        navigationItem.searchController = searchViewModel.searchController
        definesPresentationContext = true
        searchViewModel.searchController.searchBar.autocapitalizationType = .none
        searchViewModel.searchController.searchBar.delegate = self
    }
}
