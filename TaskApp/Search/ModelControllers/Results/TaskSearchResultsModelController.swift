//
//  TaskSearchResultsModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class TaskSearchResultsModelController: NSObject, QueryResultsTableViewDataSourceProtocol {
    var delegate: QueryResultsModelControllerDelegate?
    
    var keyword: String = ""
    
    var results: [TaskSearchResult] = []
    var count: Int {
        get {
            return results.count
        }
    }
    
    func loadMore(desiredCount: Int) {
        // TODO: params
        AVCloud.callFunctionInBackground("searchTasks", withParameters: nil) { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                //TODO: delegate?.didFailToLoadNewResults(self, error)
            } else {
                if let results = response as? [TaskSearchResult] {
                    if results.count > 0 {
                        self.results.appendContentsOf(results)
                        self.delegate?.didLoadNewResults(self, newResultsCount: results.count)
                    }
                    
                    if results.count < desiredCount {
                        self.delegate?.didLoadAllResultsForCriteria(self)
                    }
                }
            }
        }
    }
}

extension TaskSearchResultsModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskSearchSuggestionTableViewCell", forIndexPath: indexPath) as! TaskSearchResultTableViewCell
        return cell
    }
}