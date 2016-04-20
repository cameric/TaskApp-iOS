//
//  TaskSearchSuggestionsModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TaskSearchSuggestionsModelController: NSObject, QueryResultsTableViewDataSourceProtocol {
    var delegate: QueryResultsModelControllerDelegate?
    
    var keyword: String = ""
    
    private(set) var count: Int = 0
    
    func loadMore(desiredCount: Int) {
    }
}

extension TaskSearchSuggestionsModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // TODO
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO
        return 0
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskSearchSuggestionTableViewCell", forIndexPath: indexPath) as! TaskSearchSuggestionTableViewCell
        return cell
    }
}