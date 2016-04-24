//
//  PersonalViewController.swift
//  iosClient
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class PersonalViewController: UITableViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet var personalTableView: UITableView!
    @IBOutlet weak var accountImage: UIImageView!
    
    func toggleLogInButton() {
        if let curUser = User.currentUser() {
            nameLabel.text = curUser.name
            
            if let category = curUser.category where !category.isEmpty {
                categoryLabel.text = category.joinWithSeparator(", ")
            } else {
                categoryLabel.text = ""
            }
            
            User.currentUser()?.avatar?.getThumbnail(true, width: 80, height: 80)
            { (image: UIImage!, error: NSError!) in
                self.accountImage.alpha = 1.0
                self.accountImage.image = image
            }
        } else {
            nameLabel.text = "点击登录"
            categoryLabel.text = "或注册开始助力他人"
            self.accountImage.image = UIImage(named: "md_ic_account_circle_48pt")
            self.accountImage.alpha = 0.3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController!.navigationBar.topItem!.title = "我的"
        self.personalTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        self.personalTableView.reloadData()
        
        toggleLogInButton()
    }
    
    // Override delegate functions to hide and show logout section properly
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 && User.currentUser() == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 && User.currentUser() == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 && User.currentUser() == nil {
            return 0
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    // MARK: Actions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToProfileSegue" {
            let profileVC = segue.destinationViewController as! ProfileContainerViewController
            profileVC.userForProfile = User.currentUser()
        }
    }
    
    @IBAction func didTapLoginButton(sender: UITapGestureRecognizer) {
        if User.currentUser() != nil {
            self.performSegueWithIdentifier("ToProfileSegue", sender: self)
        } else {
            self.performSegueWithIdentifier("ToUserModuleSegue", sender: self)
        }
    }
    
    @IBAction func finishedLoggedIn(sender: UIStoryboardSegue) {
        self.personalTableView.reloadData()
        toggleLogInButton()
    }
    
    @IBAction func logout(sender: UITapGestureRecognizer) {
        self.personalTableView.reloadData()
        toggleLogInButton()
        AVUser.logOut()
    }
}