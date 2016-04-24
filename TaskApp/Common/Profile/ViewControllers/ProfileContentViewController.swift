//
//  ProfileContentViewController.swift
//  TaskApp
//
//  Created by Tony Zhang on 4/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation
import UIKit

class ProfileContentViewController: UITableViewController {
    @IBOutlet var profileContentTableView: UITableView!
    var parentBackgroundScrollView: UIScrollView?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var cateogryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userForProfile: User?
    var profileNavControl: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.profileContentTableView.backgroundColor = UIColor.clearColor()
        for i in 1..<profileContentTableView.numberOfSections {
            for j in 0..<profileContentTableView.numberOfRowsInSection(i) {
                if let cell = profileContentTableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    cell.backgroundColor = UIColor.whiteColor()
                }
            }
        }
        
        if let nav = self.profileNavControl {
            nav.navigationBar.tintColor = UIColor.lightGrayColor()
            nav.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.translucent = true
            nav.navigationBar.backgroundColor = UIColor.clearColor()
            nav.view.backgroundColor = UIColor.clearColor()
        }
        
        self.nameLabel.textColor = UIColor.whiteColor()
        self.cateogryLabel.textColor = UIColor.whiteColor()
        
        if let curUser = self.userForProfile {
            self.nameLabel.text = curUser.name
            
            if let category = curUser.category where !category.isEmpty {
                self.cateogryLabel.text = category.joinWithSeparator(", ")
            } else {
                self.cateogryLabel.text = ""
            }
            
            curUser.avatar?.getThumbnail(true, width: 100, height: 100)
            { (image: UIImage!, error: NSError!) in
                self.avatar.alpha = 1.0
                self.avatar.image = image
            }
        } else {
            print("Invalid login!")
        }

    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileGeneralInfo")
//        cell!.backgroundColor = UIColor.clearColor()
//        return cell!
//    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentScale = -self.profileContentTableView.contentOffset.y * 10 / self.view.bounds.size.height
        let barAlpha = (-currentScale > 1) ? 1 : -currentScale

        if let scrollView = self.parentBackgroundScrollView {
            updateZoomScale(scrollView, currentScale: currentScale)
        }
        
        // set navigation bar translucent
        if let nav = self.profileNavControl {
            updateBarAlpha(nav, barAlpha: barAlpha)
        }

    }
    
    private func updateZoomScale(scrollView: UIScrollView, currentScale: CGFloat) {
        if currentScale > 0 {
            scrollView.setZoomScale(scrollView.minimumZoomScale + currentScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
//    private setTransparentBackground
    
    private func updateBarAlpha(nav: UINavigationController, barAlpha: CGFloat) {
        if barAlpha != 0 {
            nav.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
            nav.navigationBar.subviews[0].alpha = barAlpha
        }
    }
}
