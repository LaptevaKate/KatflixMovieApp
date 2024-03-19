//
//  SearchMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import UIKit
import RealmSwift

final class SearchMoviesViewController: UIViewController {
    
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
            let cell = self.searchTableView.dequeueReusableCell(forIndexPath: indexPath) as SearchMovieCustomCell
            cell.backgroundColor = .black
            self.searchViewModel.getTitleForItem(item: itemIdentifier, cell: cell)
            self.searchViewModel.getPosterForItem(item: itemIdentifier, cell: cell)
            self.searchViewModel.formatReleaseDate(item: itemIdentifier, cell: cell)
            self.searchViewModel.displayVoteAverage(item: itemIdentifier, cell: cell)
            self.searchViewModel.checkForFavorite(item: itemIdentifier, cell: cell)
            self.searchViewModel.identifyVoteSymbol(item: itemIdentifier, cell: cell)
            return cell
        })
        searchTableView.rowHeight = 130
        searchTableView.delegate = self
        searchTableView.register(SearchMovieCustomCell.self)
        searchTableView.frame = view.bounds
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.backgroundColor = .black
        view.addSubview(searchTableView)
    }
}

extension SearchMoviesViewController:  UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("didEndEditing")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("buttonClicked")
        searchViewModel.getSearchResults(query: searchQuery ?? "", page: 1)
    }
}

extension SearchMoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchQuery = searchController.searchBar.text ?? ""
    }
    private func configureSearchController() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchViewModel.searchController.searchResultsUpdater = self
        searchViewModel.searchController.obscuresBackgroundDuringPresentation = false
        searchViewModel.searchController.searchBar.enablesReturnKeyAutomatically = true
        searchViewModel.searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search Movies", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        navigationItem.searchController = searchViewModel.searchController
        definesPresentationContext = true
        searchViewModel.searchController.searchBar.autocapitalizationType = .none
        searchViewModel.searchController.searchBar.delegate = self
    }
}
