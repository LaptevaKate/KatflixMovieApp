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
        OnboardingSlide(title: NSLocalizedString("titleSlide1", comment: ""),
                        description: NSLocalizedString("descriptionSlide1", comment: ""),
                        image: UIImage(named: "Slide1")),
        OnboardingSlide(title: NSLocalizedString("titleSlide2", comment: ""),
                        description: NSLocalizedString("descriptionSlide2", comment: ""),
                        image: UIImage(named: "Slide2")),
        OnboardingSlide(title: NSLocalizedString("titleSlide3", comment: ""),
                        description: NSLocalizedString("descriptionSlide3", comment: " "),
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
