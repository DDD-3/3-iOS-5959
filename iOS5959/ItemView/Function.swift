//
//  Function.swift
//  iOS5959
//
//  Created by mong on 2020/01/08.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

enum itemInputState {
    case title
    case price
    case reason
}

enum AssetsColor{
    case primaryCoral
    case secondaryCement
}

extension UIColor {
    static func customColor(_ name: AssetsColor) -> UIColor{
        switch name {
        case .primaryCoral:
            return UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        case .secondaryCement:
            return UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        }
    }
}
