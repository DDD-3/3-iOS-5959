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
    
    @nonobjc class var primaryBlack: UIColor {
        return UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1)
    }
    
    @nonobjc class var primaryGrey: UIColor {
        return UIColor(red: 0.416, green: 0.416, blue: 0.416, alpha: 1)
    }
    
    @nonobjc class var primaryCement: UIColor {
        return UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
    }
    
    @nonobjc class var secondaryBlack: UIColor {
        return UIColor(red: 0.286, green: 0.286, blue: 0.286, alpha: 1)
    }
    
    @nonobjc class var secondaryGrey: UIColor {
        return UIColor(red: 0.667, green: 0.663, blue: 0.647, alpha: 1)
    }
    
    @nonobjc class var secondaryCement: UIColor {
        return UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
    }
    
    @nonobjc class var inactiveBlack: UIColor {
        return UIColor(red: 0.765, green: 0.765, blue: 0.765, alpha: 1)
    }
    
    @nonobjc class var inactiveGrey: UIColor {
        return UIColor(red: 0.835, green: 0.835, blue: 0.835, alpha: 1)
    }
    
    @nonobjc class var primaryCoral: UIColor {
        return UIColor(red: 1, green: 0.412, blue: 0.38, alpha: 1)
    }
    
    @nonobjc class var primaryRed: UIColor {
        return UIColor(red: 0.851, green: 0.118, blue: 0.094, alpha: 1)
    }
    
    @nonobjc class var primaryPink: UIColor {
        return UIColor(red: 0.859, green: 0.039, blue: 0.357, alpha: 1)
    }
    
    @nonobjc class var primaryIndigo: UIColor {
        return UIColor(red: 0.49, green: 0.478, blue: 1, alpha: 1)
    }
    
    @nonobjc class var primaryPurple: UIColor {
        return UIColor(red: 0.302, green: 0.075, blue: 0.82, alpha: 1)
    }
    
    @nonobjc class var primaryViolet: UIColor {
        return UIColor(red: 0.855, green: 0.561, blue: 1, alpha: 1)
    }
    
    @nonobjc class var primaryYellow: UIColor {
        return UIColor(red: 1, green: 0.702, blue: 0.251, alpha: 1)
    }
    
    @nonobjc class var primaryGreen: UIColor {
        return UIColor(red: 0.188, green: 0.859, blue: 0.357, alpha: 1)
    }
    
    @nonobjc class var primarySky: UIColor {
        return UIColor(red: 0.439, green: 0.843, blue: 1, alpha: 1)
    }
    
    @nonobjc class var primaryOcean: UIColor {
        return UIColor(red: 0.251, green: 0.612, blue: 1, alpha: 1)
    }
    
    @nonobjc class var primaryBlue: UIColor {
        return UIColor(red: 0.173, green: 0.366, blue: 1, alpha: 1)
    }
    
    @nonobjc class var inactiveCoral: UIColor {
        return UIColor(red: 1, green: 0.933, blue: 0.945, alpha: 1)
    }
    
    @nonobjc class var inactiveRed: UIColor {
        return UIColor(red: 1, green: 0.796, blue: 0.804, alpha: 1)
    }
    
    @nonobjc class var inactivePink: UIColor {
        return UIColor(red: 0.98, green: 0.729, blue: 0.808, alpha: 1)
    }
    
    @nonobjc class var inactiveIndigo: UIColor {
        return UIColor(red: 0.918, green: 0.91, blue: 1, alpha: 1)
    }
    
    @nonobjc class var inactivePurple: UIColor {
        return UIColor(red: 0.835, green: 0.761, blue: 0.961, alpha: 1)
    }
    
    @nonobjc class var inactiveViolet: UIColor {
        return UIColor(red: 0.969, green: 0.898, blue: 1, alpha: 1)
    }
    
    @nonobjc class var inactiveYellow: UIColor {
        return UIColor(red: 1, green: 0.871, blue: 0.682, alpha: 1)
    }
    
    @nonobjc class var inactiveGreen: UIColor {
        return UIColor(red: 0.765, green: 0.953, blue: 0.784, alpha: 1)
    }
    
    @nonobjc class var inactiveSky: UIColor {
        return UIColor(red: 0.875, green: 0.965, blue: 1, alpha: 1)
    }
    
    @nonobjc class var inactiveOcean: UIColor {
        return UIColor(red: 0.749, green: 0.878, blue: 1, alpha: 1)
    }
    
    @nonobjc class var inactiveBlue: UIColor {
        return UIColor(red: 0.765, green: 0.776, blue: 0.996, alpha: 1)
    }
    
    @nonobjc class var wishBall2: UIColor {
        return UIColor(red: 1, green: 0.863, blue: 0.855, alpha: 1)
    }
}
