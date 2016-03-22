//
//  ForgetPasswordModelController.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

class ForgetPasswdModelController : NSObject, UserSystemModelControllerProtocol {
    var currentUser: AVUser?
    var delegate: UserSystemModelControllerDelegate?
    
    func sendForgetPasswdEmail(email: String) {
        // Construct new user
        AVUser.requestPasswordResetForEmailInBackground(email, block: { (succeeded: Bool, error: NSError!) -> Void in
            if succeeded {
                self.delegate?.didRetrieveCurrentUserInfo(self)
            } else {
                self.delegate?.didFailedLoadingUserInfo(self, action: "ForgetPasswd", errorMsg: "\(error.localizedDescription)")
            }
        })
    }
}

