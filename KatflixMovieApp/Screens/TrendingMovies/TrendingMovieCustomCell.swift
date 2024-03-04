//
//  TrendingMovieCustomCell.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 1.03.24.
//

import Foundation
import UIKit

class TrendingMovieCustomCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let releaseLabel = UILabel()
    let poster = UIImageView()
    let alreadyFavoritedButton = UIButton()
    var voteAverage = UIButton()
    var isAlreadyInFavorites: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        configSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        titleLabel.text = ""
        releaseLabel.text = ""
        voteAverage.titleLabel?.text = ""
        poster.image = nil
    }
    
    private func configSubviews() {
        let subviews = [titleLabel, poster, releaseLabel, voteAverage, alreadyFavoritedButton]
        subviews.forEach { addSubview($0) }
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .left
        titleLabel.lineBreakStrategy = .standard
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.textColor = .white
        
        
        releaseLabel.adjustsFontSizeToFitWidth = true
        releaseLabel.textAlignment = .left
        releaseLabel.lineBreakStrategy = .standard
        releaseLabel.numberOfLines = 0
        releaseLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        releaseLabel.textColor = .white
        
        voteAverage.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        voteAverage.setTitleColor(.systemOrange, for: .normal)
        voteAverage.backgroundColor = .tertiarySystemFill
        voteAverage.layer.cornerRadius = 8
        
        var btnConfig = UIButton.Configuration.tinted()
        btnConfig.cornerStyle = .capsule
        btnConfig.baseBackgroundColor = .white
        btnConfig.baseForegroundColor = .white
        btnConfig.title = "On your list!"
        btnConfig.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        btnConfig.buttonSize = .mini
        alreadyFavoritedButton.configuration = btnConfig
        
        let padding: CGFloat = 10.0
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            poster.widthAnchor.constraint(equalToConstant: 162),
            poster.heightAnchor.constraint(equalToConstant: 288),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            releaseLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: padding),
            
            voteAverage.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: padding),
            voteAverage.leadingAnchor.constraint(equalTo: releaseLabel.leadingAnchor, constant: 0),
            
            alreadyFavoritedButton.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: 0),
            alreadyFavoritedButton.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: padding),
            alreadyFavoritedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    func getPosterFromURL(posterPath: String) {
        NetworkManager.shared.getPosterImage(posterPath: posterPath) { image in
            DispatchQueue.main.async {
                self.poster.image = image
            }
        }
    }
}
