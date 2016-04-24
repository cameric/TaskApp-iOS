//
//  ProfileContainerViewController.swift
//  TaskApp
//
//  Created by Tony Zhang on 4/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation
import UIKit

class ProfileContainerViewController : UIViewController {
    var userForProfile: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileLoadSegue" {
            let profileContentVC = segue.destinationViewController as! ProfileViewController
            profileContentVC.userForProfile = self.userForProfile
            profileContentVC.profileNavControl = self.navigationController
        }
    }
    
    
}