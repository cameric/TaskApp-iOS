//
//  UserModel.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud

class User: AVUser {
    @NSManaged var name: String!
    
    static func signUpInBackgroundWithUsername(
        username: String, password: String,
        completion: (succeeded: Bool, error: NSError!) -> Void)
    {
        let newUser = User()
        
        newUser.username = username
        newUser.password = password
        
        newUser.signUpInBackgroundWithBlock(completion)
    }
    
    static func signUpInBackgroundWithWeiboUid(
        uid: String, accessToken: String,
        completion: (succeeded: Bool, error: NSError!) -> Void)
    {
        AVCloud.callFunctionInBackground("signUpWithWeibo", withParameters: nil)
        { (response: AnyObject!, error:NSError!) in
            if (error != nil) {
                completion(succeeded: false, error: error)
            } else {
                // TODO: Perform actual login operations here -- save the returned user etc.
                if let newUser = response as? User {
                    User.changeCurrentUser(newUser, save: true)
                    completion(succeeded: true, error: nil)
                } else {
                    completion(succeeded: false, error: nil) // TODO: how do I make my own error here?
                }
            }
        }
    }
}
