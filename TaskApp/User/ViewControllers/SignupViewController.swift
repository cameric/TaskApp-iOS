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

class SignupViewController: UIViewController, UITextFieldDelegate, UserSystemModelControllerDelegate {
    
    // Properties
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPwd: UITextField!
    @IBOutlet weak var acceptLicense: UISwitch!
    @IBOutlet weak var invalidInputLabel: UILabel!
    
    var showSignupInfo: Bool = false
    var signupModelController = LocalUserModelController()
    
    // MARK: Default actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputName.delegate = self
        inputEmail.delegate = self
        inputPwd.delegate = self
        signupModelController.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return UserInterfaceServices.textFieldResignResponder(textField)
    }
    
    @IBAction func dismissKeyboardDidTapOutsideTextField(sender: UITapGestureRecognizer) {
        inputName.resignFirstResponder()
        inputEmail.resignFirstResponder()
        inputPwd.resignFirstResponder()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signedupJumpToProfileSegue" {
            // Pass the logged in info to detailed profile view controller
            let targetViewController = segue.destinationViewController as! PersonalViewController
            targetViewController.currentUser = signupModelController.currentUser
        }
    }
    
    // MARK: Custom actions
    @IBAction func signup(sender: UIButton) {
        if showSignupInfo {
            showSignupInfo = false;
            self.invalidInputLabel.text = ""
        }
        
        // User input check
        guard let name = inputName!.text where name != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "昵称不能为空"
            return
        }
        guard let username = inputEmail!.text where username != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "邮箱不能为空"
            return
        }
        guard let pwd = inputPwd!.text where pwd != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "密码不能为空"
            return
        }
        guard acceptLicense!.on else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "请同意平台协议"
            return
        }
        
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "注册中..."
        
        // Call MC to register
        signupModelController.signUp(username, name: name, email: username, passwd: pwd)
    }

    // Called when the user has been successfully signed up
    func didRetrieveCurrentUserInfo<ModelController : UserSystemModelControllerProtocol>(controller: ModelController) {
        // First hide notification
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
        self.performSegueWithIdentifier("signedupJumpToProfileSegue", sender: self)
    }
    
    // Called when error occurred during signup process
    func didFailedLoadingUserInfo<ModelController : UserSystemModelControllerProtocol>(controller: ModelController, action: String, errorMsg: String) {
        // First hide notification
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
        self.showSignupInfo = true
        self.invalidInputLabel.text = errorMsg
    }
}