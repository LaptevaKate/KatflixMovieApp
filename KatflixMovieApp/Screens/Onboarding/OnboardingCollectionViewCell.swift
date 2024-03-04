//
//  OnboardingCollectionViewCell.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 20.02.24.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setupCollectionViewCell(viewModel: OnboardingModel) {
        slideImageView.image = viewModel.image
        slideTitleLabel.text = viewModel.title
        slideDescriptionLabel.text = viewModel.description
    }
}
