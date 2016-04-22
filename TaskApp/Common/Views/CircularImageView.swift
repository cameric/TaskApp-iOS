//
//  CircularImageView.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/28.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        cropToCircle()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        cropToCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cropToCircle()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        cropToCircle()
    }
    
    private func cropToCircle() {
        layer.cornerRadius = frame.size.height / 2;
        layer.masksToBounds = true;
        layer.borderWidth = 0;
    }
}
