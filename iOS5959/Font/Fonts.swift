//
//  Fonts.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/23.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

struct NanumFontName {
    static let light = "NanumSquareRoundL"
    static let regular = "NanumSquareRoundR"
    static let bold = "NanumSquareRoundB"
    static let extraBold = "NanumSquareRoundEB"
}

extension UIFont {
    @objc class func nanumLightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: NanumFontName.light, size: size)!
    }
    
    @objc class func nanumRegularFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: NanumFontName.regular, size: size)!
    }
    
    @objc class func nanumBoldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: NanumFontName.bold, size: size)!
    }
    
    @objc class func nanumExtraBoldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: NanumFontName.extraBold, size: size)!
    }
}
