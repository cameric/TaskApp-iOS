//
//  PersonModel.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/17.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud

class Person: AVObject, AVSubclassing {
    @NSManaged var name: String
    
    // TODO: I'm not sure how AVObject expects to be initialized!
    // Once implementing network access for real, fix this
    init(name: String) {
        super.init()
        self.name = name
    }
}