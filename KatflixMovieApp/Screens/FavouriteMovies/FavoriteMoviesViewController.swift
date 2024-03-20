//
//  FavoriteMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import UIKit


protocol FavoritesVCDelegate: AnyObject {
    func isAlreadyInFavorites(id: Int) -> Bool
}

final class FavoriteMoviesViewController: UIViewController, FavoritesViewModelDelegate {
    // MARK: private properties
    private let favoritesTableView = UITableView()
    private weak var delegate: FavoritesVCDelegate?
    private let favoritesViewModel = FavoriteMoviesViewModel()
    // MARK: VC Lifecycle - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewModel.delegate = self
        configureTableview()
    }
    // MARK: VC Lifecycle - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel.updateRealmDataBase()
    }
}
// MARK: - extension -  UITableViewDelegate
extension FavoriteMoviesViewController: UITableViewDelegate {
    private func configureTableview() {
        favoritesViewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: favoritesTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = self.favoritesTableView.dequeueReusableCell(forIndexPath: indexPath) as FavoriteMovieCustomCell
            cell.backgroundColor = .black
            cell.configureCell(with: itemIdentifier)
            return cell
        })
        
        favoritesTableView.delegate = self
        favoritesTableView.register(FavoriteMovieCustomCell.self)
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
