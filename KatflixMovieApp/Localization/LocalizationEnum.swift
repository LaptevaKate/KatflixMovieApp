//
//  LocalizationEnum.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import Foundation

enum OnboardingSlidesLocalization {
    case titleSlide1
    case descriptionSlide1
    case titleSlide2
    case descriptionSlide2
    case titleSlide3
    case descriptionSlide3
    case nextButton
    case getStarted
    
    var string: String {
        switch self {
        case .titleSlide1:
            return NSLocalizedString(ConstantText.titleSlide1.rawValue, comment: "")
        case .descriptionSlide1:
            return NSLocalizedString(ConstantText.descriptionSlide1.rawValue, comment: "")
        case .titleSlide2:
            return NSLocalizedString(ConstantText.titleSlide2.rawValue, comment: "")
        case .descriptionSlide2:
            return NSLocalizedString(ConstantText.descriptionSlide2.rawValue, comment: "")
        case .titleSlide3:
            return NSLocalizedString(ConstantText.titleSlide3.rawValue, comment: "")
        case .descriptionSlide3:
            return NSLocalizedString(ConstantText.descriptionSlide3.rawValue, comment: "")
        case .nextButton:
            return NSLocalizedString("Next", comment: "")
        case .getStarted:
            return NSLocalizedString("Get Started", comment: "")
            
        }
    }
}

enum TrendingMoviesLocalization {
    
}

enum DetailMoviesLocalization {
    
}

enum FavouriteMoviesLocalization {
    
}
enum SearchMoviesLocalization {
    
}
