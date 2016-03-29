//
//  LoginViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 12/26/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud
import MBProgressHUD

class LoginViewController: MultiTextFieldViewController {
    
    // MARK: Properties
    @IBOutlet weak var emailField: UITextField! {
        didSet {
            emailField.delegate = self
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.delegate = self
        }
    }
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        whitelistedViews = [emailField, passwordField]
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        // User input check
        guard let username = emailField!.text where !username.isEmpty else {
            statusLabel.text = "邮箱不能为空" // TODO: internationalize
            return
        }
        guard let password = passwordField!.text where !password.isEmpty else {
            statusLabel.text = "密码不能为空" // TODO: internationalize
            return
        }
        
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "登录中..." // TODO: internationalize
        
        User.logInWithUsernameInBackground(username, password: password) { (user: AVUser!, error: NSError!) in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if (error != nil) {
                self.statusLabel.text = "发生错误" // TODO: internationalize
            } else {
                self.statusLabel.text = "登陆成功"
                
                // NOTE: We don't need to pass the logged in user to the profile page
                // since that VC can just call User.currentUser()
                self.performSegueWithIdentifier("loggedInJumpToProfileSegue",
                                                sender: self)
            }
        }
    }
    
    @IBAction func cancelLogin(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}