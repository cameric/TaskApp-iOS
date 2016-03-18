//
//  SearchSuggestion.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud

class SearchSuggestion: AVObject, AVSubclassing {
    // Make properties @NSManaged if they're supposed to come from AVCloud
    var title: String!
    
    init(title: String) {
        super.init()
        self.title = title
    }
}