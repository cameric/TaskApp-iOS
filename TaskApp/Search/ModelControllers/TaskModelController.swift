//
//  TaskModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TaskModelController: NSObject, SearchResultModelControllerProtocol {
    var results: [Task] = []
    var delegate: SearchResultModelControllerDelegate?
    
    func loadMore(desiredCount: Int) {
        
    }
}

extension TaskModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskTableViewCell", forIndexPath: indexPath) as! SearchSuggestionTableViewCell
        return cell
    }
}