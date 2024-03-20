//
//  FavoriteMoviesViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 29.02.24.
//

import UIKit
import RealmSwift

protocol FavoritesViewModelDelegate : AnyObject { }

final class FavoriteMoviesViewModel {
    // MARK: private properties
    private let realm = try! Realm()
    private var favoriteMovies: [RealmMovieModel] = []
    // MARK: properties
    weak var delegate: FavoritesViewModelDelegate?
    var diffableDataSource : UITableViewDiffableDataSource<Section, RealmMovieModel>!
    
    init() {
        let realmData = realm.objects(RealmMovieModel.self)
        self.favoriteMovies = Array(realmData)
    }
    // MARK: private methods
    private func updateDataSource(diffableDataSource: UITableViewDiffableDataSource<Section, RealmMovieModel>) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RealmMovieModel>()
        snapshot.appendSections([.favorites])
        snapshot.appendItems(self.favoriteMovies)
        diffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        print("diff snapshot updated")
    }
    // MARK: methods
    func didTapFavoriteCell(tappedCell: FavoriteMovieCustomCell, indexPath: IndexPath) -> UIAlertController {
        let textTitle = NSLocalizedString("alertTitleFavoriteVM", comment: "")
        let textMessage = NSLocalizedString("alertMessageFavoriteVM", comment: "")
        let cancelAlertText = NSLocalizedString("cancelTitleFavoriteVM", comment: "")
        let removeAlertText = NSLocalizedString("removeTitleFavoriteVM", comment: "")
        
        let alert = UIAlertController(title: textTitle,
                                      message: textMessage + " " + tappedCell.titleLabel.text! + "?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelAlertText,
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: removeAlertText,
                                      style: .destructive,
                                      handler: {(alert: UIAlertAction!) in
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
    
    func getPosterFromURL(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        NetworkManager.shared.getPosterImage(posterPath: posterPath) { image in
            completion(image)
        }
    }
}
// MARK: - extension -  DetailMoviesDelegate
extension FavoriteMoviesViewModel: DetailMoviesDelegate {
    func updateRealmDataBase() {
        let realmData = realm.objects(RealmMovieModel.self)
        self.favoriteMovies = Array(realmData)
        self.updateDataSource(diffableDataSource: self.diffableDataSource)
    }
}
