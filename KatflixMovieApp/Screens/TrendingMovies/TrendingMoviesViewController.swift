//
//  TrendingMoviesViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    @IBOutlet weak var trendingTableView: UITableView!
    
}
extension TrendingMoviesViewController: TrendingViewModelDelegate {
    func didFetchMovieDetails() {
        
        
    }
    
}
