//
//  UIColor+Hex.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        self.init(red: (CGFloat((hex & 0xff0000) >> 16)) / 255.0, green: (CGFloat((hex & 0xff00) >> 8)) / 255.0, blue: (CGFloat(hex & 0xff)) / 255.0, alpha: 1.0)
    }
    
    struct Button {
        static let purple = UIColor(hex: 0x6441a5)
    }
    
    struct Text {
        static let darkGrey = UIColor(hex: 0x262626)
    }
    
    struct Border {
        static let around = UIColor(hex: 0xF1F1F1)
    }
    
    struct Background {
        static let grey = UIColor(hex: 0xF1F1F1)
    }
    
    struct NavBar {
        static let purple = UIColor(hex: 0x6441a5)
    }
}
