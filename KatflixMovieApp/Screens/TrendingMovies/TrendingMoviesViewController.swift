//
//  TrendingMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import UIKit

final class TrendingMoviesViewController: UIViewController {
    
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
        trendingViewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: trendingTableView, cellProvider: { [self] tableView, indexPath, itemIdentifier in
            let cell = trendingTableView.dequeueReusableCell(forIndexPath: indexPath) as TrendingMovieCustomCell
            cell.backgroundColor = .black
            cell.configureCell(with: itemIdentifier)
            cell.voteAverage.setTitleColor(self.trendingViewModel.voteAverageColorCheck(voteAverage: itemIdentifier.voteAverage!), for: .normal)
            cell.alreadyFavoritedButton.isHidden = self.trendingViewModel.isAlreadyInFavorites(id: itemIdentifier.id)
            return cell
        })
        trendingTableView.delegate = self
        trendingTableView.register(TrendingMovieCustomCell.self)
        trendingTableView.frame = view.bounds
        trendingTableView.translatesAutoresizingMaskIntoConstraints = false
        trendingTableView.rowHeight = 310
        trendingTableView.backgroundColor = .black
        view.addSubview(trendingTableView)
    }
}

// MARK: Delegation
extension TrendingMoviesViewController: TrendingViewModelDelegate {
    func didFetchMovieDetails() {
    }
}

