//
//  MovieDetailSectionHeaderView.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-18.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit
import SnapKit

class MovieDetailSectionHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.text = NSLocalizedString("LABEL_RELATED_MOVIES", comment: "Similar")
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier:reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.Background.grey
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
            make.height.equalTo(36)
        }
    }
}
