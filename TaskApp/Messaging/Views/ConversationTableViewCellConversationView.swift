//
//  ConversationTableViewCellConversationView.swift
//  TaskApp
//
//  Created by Cam on 3/31/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit

class ConversationTableViewCellConversationView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        path.moveToPoint(CGPoint(x: 1, y: 1))
        path.addLineToPoint(CGPoint(x: frame.width - 1, y: 1))
        path.addLineToPoint(CGPoint(x: frame.width - 1, y: frame.height - 1))
        path.addLineToPoint(CGPoint(x: 1, y: frame.height - 1))
        path.addLineToPoint(CGPoint(x: 1, y: 1))
        UIColor.blackColor().setStroke()
        path.stroke()
    }
 

}
