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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.profileContentTableView.backgroundColor = UIColor.clearColor()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
        if let scrollView = self.parentBackgroundScrollView {
            updateZoomScale(scrollView)
        }
    }
    
    private func updateZoomScale(scrollView: UIScrollView) {
        let currentScale = -self.profileContentTableView.contentOffset.y * 10 / self.view.bounds.size.height
        print("new scale \(currentScale)")
        if currentScale > 0 {
            scrollView.setZoomScale(scrollView.minimumZoomScale + currentScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }

}
