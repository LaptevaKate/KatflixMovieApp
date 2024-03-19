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
        trendingVC.title = NSLocalizedString("trendingVCTitle", comment: "")
        trendingVC.tabBarItem = UITabBarItem(title: trendingVC.title, image: UIImage(systemName: "film.fill") , tag: 0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        UINavigationBar.appearance().backgroundColor = .black
        return UINavigationController(rootViewController: trendingVC)
    }
    
    static func createFavoritesNavigationController() -> UINavigationController {
        let favoritesVC = FavoriteMoviesViewController()
        favoritesVC.title = NSLocalizedString("favoritesVCTitle", comment: "")
        favoritesVC.tabBarItem = UITabBarItem(title: favoritesVC.title, image: UIImage(systemName: "heart.fill") , tag: 0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        UINavigationBar.appearance().backgroundColor = .black
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    static func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchMoviesViewController()
        searchVC.title = NSLocalizedString("searchVCTitle", comment: "")
        searchVC.tabBarItem = UITabBarItem(title: searchVC.title, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        UINavigationBar.appearance().backgroundColor = .black
        return UINavigationController(rootViewController: searchVC)
    }
    
    static func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().barTintColor = .black
        tabbar.viewControllers = [createFavoritesNavigationController(), createTrendingNavigationController(), createSearchNavigationController()]
        tabbar.selectedIndex = 1
        return tabbar
    }
}
