//
//  OnboardingViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import UIKit

final class OnboardingViewModel {
    // MARK: properties
    var currentPage = 0
    let slides = [
        OnboardingSlide(title: Localization.titleSlide1.localized,
                        description: Localization.descriptionSlide1.localized,
                        image: UIImage(named: "Slide1")),
        OnboardingSlide(title: Localization.titleSlide2.localized,
                        description: Localization.descriptionSlide2.localized,
                        image: UIImage(named: "Slide2")),
        OnboardingSlide(title: Localization.titleSlide3.localized,
                        description: Localization.descriptionSlide3.localized,
                        image: UIImage(named: "Slide3"))
    ]
    
    var isLastSlide: Bool {
        return currentPage == slides.count - 1
    }
    // MARK: methods
    func moveToNextSlide() {
        currentPage += 1
    }
}
