//
//  OnboardingViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import UIKit

final class OnboardingViewModel {
    
    var currentPage = 0 

    let slides = [
        OnboardingSlide(title: OnboardingSlidesLocalization.titleSlide1.string,
                        description: OnboardingSlidesLocalization.descriptionSlide1.string,
                        image: UIImage(named: "Slide1")),
        OnboardingSlide(title: OnboardingSlidesLocalization.titleSlide2.string,
                        description: OnboardingSlidesLocalization.descriptionSlide2.string,
                        image: UIImage(named: "Slide2")),
        OnboardingSlide(title: OnboardingSlidesLocalization.titleSlide3.string,
                        description: OnboardingSlidesLocalization.descriptionSlide3.string,
                        image: UIImage(named: "Slide3"))]
    
    var isLastSlide: Bool {
        return currentPage == slides.count - 1
    }
    
    func moveToNextSlide() {
        currentPage += 1
    }
}
