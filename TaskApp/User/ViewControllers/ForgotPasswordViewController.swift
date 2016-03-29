//
//  ForgetPasswordViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/4/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class ForgotPasswordViewController: MultiTextFieldViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whitelistedViews.append(emailField)
        
        // TODO: Do this or not? Depends on how you want to display this field
        statusLabel.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Action
    @IBAction func sendPasswordRecoveryEmail(sender: UIButton) {
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "正在发送验证邮件..." // TODO: Put this in .strings
        
        User.requestPasswordResetForEmailInBackground(emailField.text) { (succeeded: Bool, error: NSError!) in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            self.statusLabel.hidden = false
            if (succeeded) {
                self.statusLabel.text = "邮件已发送！"
            } else {
                // TODO: Handle specific errors if necessary
                self.statusLabel.text = "发生错误"
            }
        }
    }
}
