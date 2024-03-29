//
//  DetailMovieView.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import Foundation
import UIKit

protocol MovieDetailViewDelegate : AnyObject {
    func didTapFavoriteButton()
}

final class MovieDetailView: UIView {
    // MARK: properties
    var backdropImage = UIImageView()
    var titleName = UILabel()
    var releaseDate = UILabel()
    var overview = UILabel()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var voteAverage = UILabel()
    let addToFavoritesButton = UIButton()
    weak var delegate: MovieDetailViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: method
    @objc func didTapButton() {
        self.delegate!.didTapFavoriteButton()
    }
    // MARK: private methods
    private func configLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(backdropImage)
        stackView.addArrangedSubview(scrollView)
        
        [titleName, overview, releaseDate, voteAverage, addToFavoritesButton].forEach { scrollView.addSubview($0) }
        
        [stackView, scrollView, backdropImage, titleName, releaseDate, voteAverage, overview, addToFavoritesButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backdropImage.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            backdropImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            backdropImage.heightAnchor.constraint(equalToConstant: stackView.bounds.width),
            
            scrollView.topAnchor.constraint(equalTo: backdropImage.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            titleName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleName.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            titleName.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            
            overview.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 8),
            overview.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            overview.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            
            releaseDate.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 24),
            releaseDate.leadingAnchor.constraint(equalTo: voteAverage.trailingAnchor, constant: 10),
            releaseDate.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -12),
            
            voteAverage.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 24),
            voteAverage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 12),
            voteAverage.trailingAnchor.constraint(equalTo: releaseDate.leadingAnchor, constant: -10),
            
            addToFavoritesButton.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 20),
            addToFavoritesButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        
        backdropImage.contentMode = .scaleAspectFill
        backdropImage.clipsToBounds = true
        backdropImage.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        titleName.numberOfLines = 0
        titleName.lineBreakStrategy = .standard
        titleName.font = .customFont(font: .titleFont, size: .large)
        titleName.textColor = .white
        
        overview.numberOfLines = 0
        overview.lineBreakStrategy = .standard
        overview.font = .customFont(font: .textFont2, size: .medium)
        overview.textColor = .white
        
        releaseDate.numberOfLines = 1
        releaseDate.textAlignment = .right
        releaseDate.font = .customFont(font: .textFont2, size: .small)
        releaseDate.textColor = .white
        
        voteAverage.numberOfLines = 1
        voteAverage.textAlignment = .left
        voteAverage.font = .customFont(font: .textFont2, size: .small)
        voteAverage.textColor = .white
        
        addToFavoritesButton.setTitle(NSLocalizedString("addToFavoritesButtonDetailV", comment: ""), for: .normal)
        addToFavoritesButton.backgroundColor = .red
        addToFavoritesButton.layer.cornerRadius = 8
        addToFavoritesButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
}
