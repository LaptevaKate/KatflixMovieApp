//
//  LocalizationEnum.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import Foundation

enum Localization: String {
    //Onboarding
    case titleSlide1 = "Incredible emotions"
    case descriptionSlide1 = "An exciting storyline will take you into a fantasy world or help you experience all the variety of real storylines"
    case titleSlide2 = "Unique experiences"
    case  descriptionSlide2 = "The combination of colorful images and high-quality sound will give you a unique experience"
    case titleSlide3 = "Amazing graphics"
    case descriptionSlide3 = "Immerse yourself in a world filled with picturesque illustrations, or in everyday life with qualitatively drawn locations and characters"
    case nextButtonOnboarding = "Next"
    case getStartedOnboarding = "Get Started"
//TrendingMovies
    case trendingVCTitle = "Trending Movies"
    case btnTitleTrendingCell = "In Favorites"
//DetailMovies
    case scoreTextDetailVC = "Score: "
    case releaseDateTextDetailVC = "Release Date: "
    case alertTitleDetailVC = "Added"
    case alertMessageDetailVC = "Let's Watch Later"
    case alertOKDetailVC = "ОК"
    case addToFavoritesButtonDetailVC = "Add To Favorites"
//FavouriteMovies
    case favoritesVCTitle = "Favorite Movies"
    case alertTitleFavoriteVM = "Remove from Favorites"
    case alertMessageFavoriteVM = "Do You want to delete"
    case cancelTitleFavoriteVM = "Cancel"
    case removeTitleFavoriteVM = "Remove"
//SearchMovies
    case searchVCTitle = "Search the Movie"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
