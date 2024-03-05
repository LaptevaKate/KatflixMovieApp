//
//  FavoriteMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import UIKit
import RealmSwift

protocol FavoritesVCDelegate: AnyObject {
    func isAlreadyInFavorites(id: Int) -> Bool
}

class FavoriteMoviesViewController: UIViewController,FavoritesViewModelDelegate {
    
    let favoritesTableView = UITableView()
    
    weak var delegate: FavoritesVCDelegate?
    private let favoritesViewModel = FavoriteMoviesViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewModel.delegate = self
        configureTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel.updateDB()
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate {
    private func configureTableview() {
        favoritesViewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: favoritesTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = self.favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoriteMovieCustomCell
            cell.backgroundColor = .black
            cell.id = itemIdentifier.id
            cell.titleLabel.text = itemIdentifier.title
            cell.getPosterFromURL(posterPath: itemIdentifier.poster)
            return cell
        })
        
        favoritesTableView.delegate = self
        favoritesTableView.register(FavoriteMovieCustomCell.self, forCellReuseIdentifier: "favoritesCell")
        favoritesTableView.frame = view.bounds
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.rowHeight = 110
        favoritesTableView.backgroundColor = .black
        view.addSubview(favoritesTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesTableView.deselectRow(at: indexPath, animated: true)
        let currentCell = favoritesTableView.cellForRow(at: indexPath) as! FavoriteMovieCustomCell
        self.present(favoritesViewModel.didTapFavoriteCell(tappedCell: currentCell, indexPath: indexPath), animated: true, completion: nil)
    }
}
