//
//  UserSearchResultsModelController.swift
//  UserApp
//
//  Created by Spencer Michaels on 2016/3/17.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class UserSearchResultsModelController: NSObject, QueryResultsTableViewDataSourceProtocol {
    var delegate: QueryResultsModelControllerDelegate?
    
    var keyword: String = ""
    
    var results: [UserSearchResult] = []
    var count: Int {
        get {
            return results.count
        }
    }
    
    func loadMore(desiredCount: Int) {
        // TODO: params
        AVCloud.callFunctionInBackground("searchUsers", withParameters: nil) { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                //TODO: delegate?.didFailToLoadNewResults(self, error)
            } else {
                if let results = response as? [UserSearchResult] {
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

extension UserSearchResultsModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserSearchResultTableViewCell", forIndexPath: indexPath) as! UserSearchResultTableViewCell
        return cell
    }
}