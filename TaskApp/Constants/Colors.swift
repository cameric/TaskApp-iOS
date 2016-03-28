//
//  Colors.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/15.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    static let fgColor = UIColor.whiteColor()
    static let bgColor = UIColor.lightGrayColor()
}

// TODO: Move this somewhere better, perhaps?
extension UIColor {
    static func fromHexRGB(hexRGB: Int) -> UIColor {
        let red   = Float((hexRGB & 0xFF0000) >> 16) / 255;
        let green = Float((hexRGB & 0x00FF00) >>  8) / 255;
        let blue  = Float((hexRGB & 0x0000FF) >>  0) / 255;
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
    }
}