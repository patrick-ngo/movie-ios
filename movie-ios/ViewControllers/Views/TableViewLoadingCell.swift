//
//  TableViewLoadingCell.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit

class TableViewLoadingCell: UITableViewCell {
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.activityIndicator)
        
        self.activityIndicator.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.center.equalTo(self.contentView)
        }
        
        self.activityIndicator.startAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.activityIndicator.startAnimating()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
