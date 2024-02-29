//
//  OnboardingModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 20.02.24.
//

import UIKit

struct OnboardingModel {
    let title: String
    let description: String
    let image: UIImage?
}

extension OnboardingModel {
    static var slides = [OnboardingModel(title: OnboardingSlidesLocalization.titleSlide1.string,
                               description: OnboardingSlidesLocalization.descriptionSlide1.string,
                               image: UIImage(named: "Slide1")),
               OnboardingModel(title: OnboardingSlidesLocalization.titleSlide2.string,
                               description: OnboardingSlidesLocalization.descriptionSlide2.string,
                               image: UIImage(named: "Slide2")),
               OnboardingModel(title: OnboardingSlidesLocalization.titleSlide3.string,
                               description: OnboardingSlidesLocalization.descriptionSlide3.string,
                               image: UIImage(named: "Slide3"))]
}
