//
//  Colors.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//  WishBall Custom Color

import UIKit

extension UIColor {
    convenience init(hex: Int){
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex & 0x0000FF) / 255.0, alpha: 1)
    }
    
    @nonobjc class var redMagnet: UIColor {
        return UIColor(red: 0.922, green: 0.263, blue: 0.349, alpha: 1)
    }
    
    @nonobjc class var violetMagnet: UIColor {
        return UIColor(red: 0.329, green: 0.345, blue: 0.82, alpha: 1)
    }
    
    @nonobjc class var yellowMagnet: UIColor {
        return UIColor(red: 0.973, green: 0.8, blue: 0.278, alpha: 1)
    }
    
    @nonobjc class var required: UIColor {
        return UIColor(red: 0.922, green: 0.686, blue: 0.686, alpha: 1)
    }
    
    @nonobjc class var crimson: UIColor {
        return UIColor(red: 0.575, green: 0.029, blue: 0.029, alpha: 1)
    }
    
    @nonobjc class var wishballMain: UIColor {
        return UIColor(red: 0, green: 0.04, blue: 1, alpha: 1)
    }
}
