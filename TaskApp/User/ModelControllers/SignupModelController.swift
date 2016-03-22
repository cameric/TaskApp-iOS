//
//  SignupModelController.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

class SignupModelController : NSObject, UserSystemModelControllerProtocol {
    var currentUser: AVUser?
    var delegate: UserSystemModelControllerDelegate?
    
    func signUp(username: String, name: String, email: String, passwd: String) {
        // Construct new user
        let newUser = AVUser()
        newUser.setObject(name, forKey: "name")
        newUser.username = username
        newUser.email = username
        newUser.password = passwd
    
        newUser.signUpInBackgroundWithBlock({ (succeeded: Bool, error: NSError!) -> Void in
            if succeeded {
                self.currentUser = newUser
                self.delegate?.didRetrieveCurrentUserInfo(self)
            } else {
                self.delegate?.didFailedLoadingUserInfo(self, action: "Signup", errorMsg: "\(error.localizedDescription)")
            }
        })

    }
}
