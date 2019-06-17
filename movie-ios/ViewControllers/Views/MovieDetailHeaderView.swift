//
//  MovieDetailHeaderView.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit
import SnapKit

class MovieDetailHeaderView : UITableViewHeaderFooterView {
    private let locale = NSLocale(localeIdentifier: NSLocale.current.languageCode!)
    var movie: MovieModel? = nil {
        didSet {
            guard let movie = movie else { return }
            
            // Poster
            if let profilePic = movie.poster_path {
                let imageUrl = URL(string: "\(MoviesAPI.BASE_URL_IMAGES_HIGH)\(profilePic)")
                self.posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
            }
            
            // Title
            if let name = movie.title {
                self.titleLabel.text = name
            }
            
            if let date = movie.release_date {
                // format: 2019-06-17
                let index = date.index(date.startIndex, offsetBy: 4)
                let yearSubstring = date[..<index]
                self.yearLabel.text = String(yearSubstring)
            }
            
            // Synopsys
            if let overview = movie.overview {
                self.synopsysLabel.text = overview
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
            
            // Language
            if let original_language = movie.original_language {
                if let language = self.locale.displayName(forKey: NSLocale.Key.identifier, value: original_language) {
                    self.languageLabel.text = "\(NSLocalizedString("LABEL_LANGUAGE", comment: "Language")) \(language)"
                }
            }
            
            // Runtime
            if let runtime = movie.runtime {
                self.languageLabel.text = "\(NSLocalizedString("LABEL_RUNTIME", comment: "Runtime")) \(runtime)m"
            }
        }
    }
    
    
    //MARK: - Views -
    
    let scrollView : UIView = {
        let sv = UIView()
        sv.backgroundColor = .white
        return sv
    }()
    
    let posterImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let gradientView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 300))
        v.addGradientAtBottom()
        return v
    }()
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let synopsysLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    let genresLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    let yearLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    let languageLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    let runtimeLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier:reuseIdentifier)
        
        self.contentView.addSubview(self.scrollView)
        self.scrollView.addSubview(self.gradientView)
        self.scrollView.addSubview(self.posterImageView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.synopsysLabel)
        self.scrollView.addSubview(self.yearLabel)
        self.scrollView.addSubview(self.genresLabel)
        self.scrollView.addSubview(self.languageLabel)
        self.scrollView.addSubview(self.runtimeLabel)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        self.gradientView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.right.left.equalTo(self.contentView)
        }
        
        self.posterImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.top.equalTo(0)
            make.height.equalTo(300)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(10)
            make.left.right.equalTo(15)
        }
        
        self.genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(15)
        }
        
        self.yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.genresLabel.snp.bottom).offset(4)
            make.left.right.equalTo(15)
        }
        
        self.synopsysLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.yearLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalTo(15)
        }
        
        self.languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.synopsysLabel.snp.bottom).offset(10)
            make.left.right.equalTo(15)
        }
        
        self.runtimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.languageLabel.snp.bottom).offset(10)
            make.left.right.equalTo(15)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
