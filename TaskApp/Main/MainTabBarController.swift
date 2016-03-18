//
//  TabBarWithCenterButtonViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/14.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    @IBOutlet weak var buttonView: UIButton!
    
    // This view controller is empty and is never displayed; it's used to create a blank space
    // in the middle of the tab bar.
    let dummyVC = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tag our fake view controller's tab bar item so that it can't be selected
        dummyVC.tabBarItem = UITabBarItem(title: nil, image: nil, tag: MainTabBarControllerDelegate.unselectableTag)
        self.viewControllers?.insert(dummyVC, atIndex: self.tabBar.items!.count/2)
        
        // Insert the center button
        self.buttonView.center = self.tabBar.center
        self.buttonView.center.y -= self.tabBar.frame.size.height/4
        self.view.addSubview(buttonView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
