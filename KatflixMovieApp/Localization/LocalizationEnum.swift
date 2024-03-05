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
            return NSLocalizedString(OnboardingConstant.titleSlideTheFirst, comment: "")
        case .descriptionSlide1:
            return NSLocalizedString(OnboardingConstant.descriptionSlideTheFirst, comment: "")
        case .titleSlide2:
            return NSLocalizedString(OnboardingConstant.titleSlideTheSecond, comment: "")
        case .descriptionSlide2:
            return NSLocalizedString(OnboardingConstant.descriptionSlideTheSecond, comment: "")
        case .titleSlide3:
            return NSLocalizedString(OnboardingConstant.titleSlideTheThird, comment: "")
        case .descriptionSlide3:
            return NSLocalizedString(OnboardingConstant.descriptionSlideTheThird, comment: "")
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
