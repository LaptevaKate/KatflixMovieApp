//
//  TrendingMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import UIKit
import RealmSwift

class TrendingMoviesViewController: UIViewController {
    let realm = try! Realm()
    private let trendingViewModel = TrendingViewModel()
    
    let trendingTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingViewModel.delegate = self
        trendingViewModel.getTrendingMovies()
        configureTableview()
        applyChangesToSnapshot()
    }
    
    func applyChangesToSnapshot() {
        var snapshot = trendingViewModel.diffableDataSource.snapshot()
        snapshot.reloadItems(self.trendingViewModel.trendingMovies)
        trendingViewModel.diffableDataSource.applySnapshotUsingReloadData(snapshot)
        print("refreshing diff db")
    }
}
// MARK: UITableViewDelegate 
extension TrendingMoviesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trendingTableView.deselectRow(at: indexPath, animated: true)
        guard let selectedItem = trendingViewModel.diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        trendingViewModel.didTapMovieCell(movieID: selectedItem.id)
        navigationController?.pushViewController(DetailMoviesViewController(movie: selectedItem), animated: true)
    }
    
    private func configureTableview() {
        trendingViewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: trendingTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            let cell = self.trendingTableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as! TrendingMovieCustomCell
            cell.backgroundColor = .black
            cell.titleLabel.text = itemIdentifier.title
            cell.mediaLabel.text = itemIdentifier.mediaType?.rawValue
            cell.voteAverage.setTitle(" \(String(itemIdentifier.voteAverage!)) ", for: .normal)
            cell.getPosterFromURL(posterPath: itemIdentifier.posterPath!)
            cell.voteAverage.setTitleColor(self.trendingViewModel.voteAverageColorCheck(voteAverage: itemIdentifier.voteAverage!), for: .normal)
            cell.alreadyFavoritedButton.isHidden = self.isAlreadyInFavorites(id: itemIdentifier.id)
            
            return cell
        })
        trendingTableView.delegate = self
        trendingTableView.register(TrendingMovieCustomCell.self, forCellReuseIdentifier: "trendingCell")
        trendingTableView.frame = view.bounds
        trendingTableView.translatesAutoresizingMaskIntoConstraints = false
        trendingTableView.rowHeight = 310
        view.addSubview(trendingTableView)
    }
}

// MARK: Delegation
extension TrendingMoviesViewController: TrendingViewModelDelegate {
    func didFetchMovieDetails() {
    }
}
extension TrendingMoviesViewController: FavoritesVCDelegate {
    func isAlreadyInFavorites(id: Int) -> Bool {
        return realm.object(ofType: RealmMovieModel.self, forPrimaryKey: id) == nil
    }
}
