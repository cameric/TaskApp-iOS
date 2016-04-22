//
//  SignupViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/1/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation
import AVOSCloud
import UIKit
import MBProgressHUD

class SignupViewController: MultiTextFieldViewController {
    
    // Properties
    @IBOutlet weak var nameField: UITextField! {
        didSet {
            nameField.delegate = self
        }
    }
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
    @IBOutlet weak var licenseAcceptToggle: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: Default actions
    override func viewDidLoad() {
        super.viewDidLoad()
        whitelistedViews = [nameField, emailField, passwordField]
    }
    
    // MARK: Custom actions
    @IBAction func signup(sender: UIButton) {
        // User input check
        guard let name = nameField.text where !name.isEmpty else {
            self.statusLabel.text = "昵称不能为空"
            return
        }
        guard let username = emailField.text where !username.isEmpty else {
            self.statusLabel.text = "邮箱不能为空"
            return
        }
        guard let password = passwordField.text where !password.isEmpty else {
            self.statusLabel.text = "密码不能为空"
            return
        }
        guard licenseAcceptToggle.on else {
            self.statusLabel.text = "请同意平台协议"
            return
        }
        
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "注册中..."
        
        // TODO: Name should be set elsewhere, really -- have a "first login" screen etc
        User.signUpInBackgroundWithUsername(username, password: password) { (succeeded, error) in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if (error != nil) {
                self.statusLabel.text = "发生错误"
            } else {
                self.statusLabel.text = "注册成功"
                self.performSegueWithIdentifier("signedupJumpToProfileSegue", sender: self)
            }
        }
    }
}