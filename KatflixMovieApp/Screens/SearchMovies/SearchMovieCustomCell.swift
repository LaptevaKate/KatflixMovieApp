//
//  SearchMovieCustomCell.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import Foundation
import UIKit

final class SearchMovieCustomCell: UITableViewCell {
    // MARK: properties
    var titleLabel = UILabel()
    var releaseDate = UILabel()
    var poster = UIImageView()
    var voteAverage = UILabel()
    let voteSymbol = UIImageView()
    let alreadyFavoritedButton = UIButton()
    // MARK: methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        poster.image = nil
        titleLabel.text = nil
        releaseDate.text = nil
        voteAverage.text = nil
    }
    func getPosterFromURL(posterPath: String) {
        NetworkManager.shared.getPosterImage(posterPath: posterPath) { image in
            DispatchQueue.main.async {
                self.poster.image = image
            }
        }
    }
    // MARK: private methods
    private func configSubviews() {
        let subviews = [titleLabel, releaseDate, poster, voteAverage, voteSymbol, alreadyFavoritedButton]
        subviews.forEach { addSubview($0) }
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        titleLabel.font = .customFont(font: .textFont2, size: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakStrategy = .standard
        titleLabel.textColor = .white
        
        poster.contentMode = .scaleAspectFill
        
        releaseDate.font = .customFont(font: .textFont1, size: .small)
        releaseDate.textColor = .white
        
        voteSymbol.image = UIImage(systemName: "heart.square")?.withTintColor(.systemGray2, renderingMode: .alwaysOriginal)
        voteAverage.font = .customFont(font: .textFont1, size: .medium)
        
        var btnConfig = UIButton.Configuration.gray()
        btnConfig.cornerStyle = .capsule
        btnConfig.baseForegroundColor = UIColor.systemPink
        btnConfig.buttonSize = .mini
        btnConfig.contentInsets = .zero
        btnConfig.title = NSLocalizedString("btnTitleTrendingCell", comment: "")
        alreadyFavoritedButton.configuration = btnConfig
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            poster.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            poster.widthAnchor.constraint(equalToConstant: 70),
            poster.heightAnchor.constraint(equalToConstant: 116),
            
            titleLabel.topAnchor.constraint(equalTo: poster.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            releaseDate.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 2),
            releaseDate.bottomAnchor.constraint(equalTo: poster.bottomAnchor),
            
            voteSymbol.leadingAnchor.constraint(equalTo: alreadyFavoritedButton.trailingAnchor, constant: padding),
            voteSymbol.bottomAnchor.constraint(equalTo: poster.bottomAnchor),
            voteSymbol.trailingAnchor.constraint(equalTo: voteAverage.leadingAnchor, constant: -4),
            
            voteAverage.bottomAnchor.constraint(equalTo: poster.bottomAnchor),
            voteAverage.leadingAnchor.constraint(equalTo: voteSymbol.trailingAnchor),
            voteAverage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            alreadyFavoritedButton.leadingAnchor.constraint(equalTo: releaseDate.trailingAnchor, constant: padding),
            alreadyFavoritedButton.trailingAnchor.constraint(equalTo: voteSymbol.leadingAnchor, constant: -padding),
            alreadyFavoritedButton.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: 0)
        ])
    }
}
