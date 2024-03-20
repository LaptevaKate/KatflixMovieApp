//
//  OnboardingCollectionViewCell.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 20.02.24.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: properties
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    // MARK: IBOutlets
    @IBOutlet private weak var slideImageView: UIImageView!
    @IBOutlet private weak var slideTitleLabel: UILabel!
    @IBOutlet private weak var slideDescriptionLabel: UILabel!
    // MARK: methods
    func configure(with model: OnboardingSlide) {
        slideImageView.image = model.image
        slideTitleLabel.text = model.title
        slideDescriptionLabel.text = model.description
    }
}
