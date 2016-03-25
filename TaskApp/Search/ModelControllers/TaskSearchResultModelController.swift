//
//  TaskSearchResultModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

class TaskSearchResultModelController: NSObject, SearchResultModelControllerProtocol {
    var results: [Task] = []
    var delegate: SearchResultModelControllerDelegate?
    
    func loadMore(desiredCount: Int) {
        // TODO: params
        AVCloud.callFunctionInBackground("searchTasks", withParameters: nil) { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                //TODO: delegate?.didFailToLoadNewResults(self, error)
            } else {
                if let resultsAsTasks = response as? [Task] {
                    if resultsAsTasks.count > 0 {
                        self.results.appendContentsOf(resultsAsTasks)
                        self.delegate?.didLoadNewResults(self, newResultsCount: resultsAsTasks.count)
                    }
                    
                    if resultsAsTasks.count < desiredCount {
                        self.delegate?.didLoadAllResultsForCriteria(self)
                    }
                }
            }
        }
    }
}

extension TaskSearchResultModelController : UITableViewDataSource {
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