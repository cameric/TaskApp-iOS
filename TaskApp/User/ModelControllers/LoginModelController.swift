//
//  LoginModelController.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

class LoginModelController : NSObject, UserSystemModelControllerProtocol {
    var currentUser: AVUser?
    var delegate: UserSystemModelControllerDelegate?
    
    // Login using normal username and password
    func login(username:String, passwd:String) {
        AVUser.logInWithUsernameInBackground(username, password: passwd, block: { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                // print("登陆错误：\(error.localizedDescription) (\(error.code))")
                self.delegate?.didFailedLoadingUserInfo(self, action: "Login", errorMsg: "\(error.localizedDescription)")
            } else {
                if let loggedInUser = response as? AVUser {
                    self.currentUser = loggedInUser
                    self.delegate?.didRetrieveCurrentUserInfo(self)
                }
            }
        })
    }
    
    // Login using Weibo SDK
    func weiboLogin() {
        
    }
}