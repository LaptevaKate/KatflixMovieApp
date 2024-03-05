//
//  FavoriteMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import UIKit
import RealmSwift

protocol FavoritesViewModelDelegate : AnyObject { }

class FavoriteMoviesViewModel {
    
    weak var delegate: FavoritesViewModelDelegate?
    var diffableDataSource : UITableViewDiffableDataSource<Section, RealmMovieModel>!
    let realm = try! Realm()
    var favoriteMovies: [RealmMovieModel] = []
    init() {
        let realmData = realm.objects(RealmMovieModel.self)
        self.favoriteMovies = Array(realmData)
    }
    func updateDataSource(diffableDataSource: UITableViewDiffableDataSource<Section, RealmMovieModel>) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RealmMovieModel>()
        snapshot.appendSections([.favorites])
        snapshot.appendItems(self.favoriteMovies)
        diffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        print("diff snapshot updated")
    }
    
    func didTapFavoriteCell(tappedCell: FavoriteMovieCustomCell, indexPath: IndexPath) -> UIAlertController {
        
        let alert = UIAlertController(title: "Remove from Favorites", message: "\(tappedCell.titleLabel.text!) will be deleted from your Favorites. Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: {(alert: UIAlertAction!) in
            var snapshot = self.diffableDataSource.snapshot()
            if let item = self.diffableDataSource.itemIdentifier(for: indexPath) {
                    snapshot.deleteItems([item])
                self.diffableDataSource.apply(snapshot)
                }
            let itemToRemove = self.realm.object(ofType: RealmMovieModel.self, forPrimaryKey: tappedCell.id)

            try! self.realm.write({ self.realm.delete(itemToRemove!) })
            }))
        return alert
    }
}
extension FavoriteMoviesViewModel : DetailMoviesDelegate {
    func updateDB() {
        let realmData = realm.objects(RealmMovieModel.self)
        self.favoriteMovies = Array(realmData)
        self.updateDataSource(diffableDataSource: self.diffableDataSource)
    }
}
