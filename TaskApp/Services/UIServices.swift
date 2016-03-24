//
//  UserInterfaceServices.swift
//  iosClient
//
//  Created by Tony Zhang on 1/4/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit

/**
 This class provides some shared functions that can be useful for building user interfaces
 */
class UserInterfaceServices {
    
    /**
     Enable Next/Return/Done buttons on the keyboard when having textfield in the UI
     
     - parameter textField: the textfield reference passed in by delegate
     
     - returns: false since we do not want UITextField to insert line-breaks.
     
     - remark: every view controller that uses this function must inherit from UITextFieldDelegate
     */
    static func textFieldResignResponder(textField: UITextField) -> Bool {
        let nextTag=textField.tag + 1;
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil) {
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false
    }
    
    /**
     Construct a UIColor object from any valid hexadecimal RGB value
     
     - parameter rgbValue: a hexadecimal value representing a color
     
     - returns: a UIColor object corresponding to the rgbValue
     */
    static func UIColorFromHexRGB(rgbValue: Int) -> UIColor {
        return UIColor(colorLiteralRed: Float((rgbValue & 0xFF0000) >> 16) / Float(255),
            green: Float((rgbValue & 0x00FF00) >>  8) / Float(255.0),
            blue: Float((rgbValue & 0x0000FF) >>  0) / Float(255.0),
            alpha: 1.0)
    }
    
    /**
     Crop any valid UI image (inside a UIImageView) from default rectangular shape to circular shape.
     Works best for square images (like thunmnails)
     
     - parameter: imageView: the UIImageView that holds the image to be cropped
     */
    static func cropRectangularUIImageToCircular(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2;
        imageView.layer.masksToBounds = true;
        imageView.layer.borderWidth = 0;
    }
}