//
//  FavoriteMovieCustomCell.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 4.03.24.
//

import UIKit


final class FavoriteMovieCustomCell: UITableViewCell {
    
    var id: Int = -1
    let titleLabel = UILabel()
    let poster = UIImageView()
    let viewModel = FavoriteMoviesViewModel()
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        poster.image = nil
    }
    
    func configureCell(with model: RealmMovieModel) {
        id = model.id
        titleLabel.text = model.title
        viewModel.getPosterFromURL(posterPath: model.poster) { [weak self] image in
            DispatchQueue.main.async {
                self?.poster.image = image
            }
        }
    }

    private func configureSubviews() {
        let subviews = [titleLabel, poster]
        subviews.forEach { addSubview($0) }
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            poster.widthAnchor.constraint(equalToConstant: 60),
            poster.heightAnchor.constraint(equalToConstant: 92),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
