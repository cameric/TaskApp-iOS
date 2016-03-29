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
}
