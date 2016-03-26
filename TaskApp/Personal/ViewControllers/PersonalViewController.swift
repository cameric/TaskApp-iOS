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
    
    var currentUser: AVUser?
    
    func toggleLogInButton() {
        if let curUser = self.currentUser {
            nameLabel.text = curUser.objectForKey("name") as? String
            if let joinedCategory = curUser.objectForKey("category") as? [String] {
                categoryLabel.text = joinedCategory.joinWithSeparator(", ")
            } else {
                categoryLabel.text = ""
            }
            if let avatar = curUser.objectForKey("avatar") as? AVFile {
                avatar.getThumbnail(true, width: 80, height: 80, withBlock: {
                    (image: UIImage!, error: NSError!) -> Void in
                    if error != nil {
                        print("Loading avatar error: \(error)")
                        return
                    }
                    self.accountImage.image = image
                    UserInterfaceServices.cropRectangularUIImageToCircular(self.accountImage)
                    self.accountImage.alpha = 1
                })
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
        if let curUser = AVUser.currentUser() {
            self.currentUser = curUser
        }
        self.personalTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        self.personalTableView.reloadData()
        
        toggleLogInButton()
    }
    
    // Override delegate functions to hide and show logout section properly
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 && self.currentUser == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 && self.currentUser == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 && self.currentUser == nil {
            return 0
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier where id == "ToProfileSegue" {
            let targetViewController = segue.destinationViewController as! ProfileViewController
            targetViewController.currentUser = self.currentUser
        }
    }
    
    // MARK: Actions
    @IBAction func didTapLoginButton(sender: UITapGestureRecognizer) {
        if self.currentUser != nil {
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
        self.currentUser = nil
        self.personalTableView.reloadData()
        toggleLogInButton()
        // Clear local storage
        AVUser.logOut()
    }
}