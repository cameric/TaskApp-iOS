//
//  ProfileViewController.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/26/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

class ProfileViewController : UIViewController {
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var backgroundScrollView: UIScrollView! {
        didSet {
            backgroundScrollView.delegate = self
        }
    }
    @IBOutlet weak var profileContentView: UIView!
    var profileContentTableViewOffset: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setMinZoomScaleForSize(self.view.bounds.size)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileContentLoadSegue" {
            let profileContentVC = segue.destinationViewController as! ProfileContentViewController
            profileContentVC.parentBackgroundScrollView = self.backgroundScrollView
        }
    }
    
    private func setMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / profileBackgroundImageView.bounds.width
        let minScale = widthScale
        
        print("min scale \(minScale)")
        backgroundScrollView.minimumZoomScale = minScale
        backgroundScrollView.zoomScale = minScale
    }
}

extension ProfileViewController : UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return profileBackgroundImageView
    }
}