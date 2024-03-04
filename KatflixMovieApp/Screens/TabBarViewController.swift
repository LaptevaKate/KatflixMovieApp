//
//  TabBarViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import UIKit

final class TabBarViewController: UIViewController {
    
    static func createTrendingNavigationController() -> UINavigationController {
        let trendingVC = TrendingMoviesViewController()
        trendingVC.title = "Trending Movies"
        trendingVC.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(systemName: "film.fill") , tag: 0)
        
        return UINavigationController(rootViewController: trendingVC)
    }
    
    static func createFavoritesNavigationController() -> UINavigationController {
        let favoritesVC = FavouriteMoviesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill") , tag: 0)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    static func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchMoviesViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    static func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        tabbar.viewControllers = [createFavoritesNavigationController(), createTrendingNavigationController(), createSearchNavigationController()]
        tabbar.selectedIndex = 1
        return tabbar
    }
}
