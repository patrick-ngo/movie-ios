//
//  MovieListingsCell.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MovieListingsCell: UITableViewCell {
    
    //MARK: - Display data -
    
    var movie: MovieModel? = nil {
        didSet {
            guard let movie = movie else { return }
            
            // Title
            if let title = movie.title {
                self.titleLabel.text = title
            }
            
            // Genres
            if let genres = movie.genre_ids, genres.count > 0 {
                // Match genre ids with genre names
                let genreNames = genres.map { (genreId) -> String in
                    if let genre = Constants.Genres[genreId] {
                        return genre
                    }
                    return ""
                }
                self.genresLabel.text = genreNames.joined(separator: " • ")
            }
            
            // Poster image
            if let poster = movie.poster_path {
                let imageUrl = URL(string: "\(MoviesAPI.BASE_URL_IMAGES_LOW)\(poster)")
                self.posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
            }
        }
    }
    
    
    
    //MARK: - Views -
    
    let posterImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let genresLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK: - Init -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.setupViews()
    }
    
    func setupViews() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.genresLabel)
        
        self.posterImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.width.height.equalTo(70)
            make.top.equalTo(4)
            make.bottom.equalTo(0).offset(-4)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.posterImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView)
            make.height.equalTo(15)
            make.centerY.equalTo(self.posterImageView.snp.centerY).offset(-15)
        }
        
        self.genresLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.posterImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView)
            make.height.equalTo(16)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Methods -
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = UIColor.Button.purple.withAlphaComponent(0.3)
        } else {
            self.backgroundColor = .white
        }
    }
}
