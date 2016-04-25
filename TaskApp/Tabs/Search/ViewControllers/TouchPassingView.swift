//
//  TouchPassingView.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/25.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

/*
    @brief A UIView that passes touches through itself to its superview. Touches on subviews still register.
 */
class TouchPassingView: UIView {
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        
        if (hitView == self) {
            return nil
        }
        
        return hitView
    }
}
