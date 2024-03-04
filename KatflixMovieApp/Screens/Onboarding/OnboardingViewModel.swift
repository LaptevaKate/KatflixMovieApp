//
//  OnboardingViewModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import Foundation
import UIKit


final class OnboardingViewModel {
    var slides: [OnboardingModel] = []
    
    func createSlides() {
        slides =  [OnboardingModel(title: OnboardingSlidesLocalization.titleSlide1.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide1.string,
                                   image: UIImage(named: "Slide1")),
                   OnboardingModel(title: OnboardingSlidesLocalization.titleSlide2.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide2.string,
                                   image: UIImage(named: "Slide2")),
                   OnboardingModel(title: OnboardingSlidesLocalization.titleSlide3.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide3.string,
                                   image: UIImage(named: "Slide3"))]
    }
}
