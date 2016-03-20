//
//  UserModelController.swift
//  UserApp
//
//  Created by Spencer Michaels on 2016/3/17.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class UserModelController: NSObject, SearchResultModelControllerProtocol {
    var results: [User] = []
    var delegate: SearchResultModelControllerDelegate?
    
    func loadMore(desiredCount: Int) {
        // TODO: params
        AVCloud.callFunctionInBackground("searchUsers", withParameters: nil) { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                //TODO: delegate?.didFailToLoadNewResults(self, error)
            } else {
                if let resultsAsUsers = response as? [User] {
                    if resultsAsUsers.count > 0 {
                        self.results.appendContentsOf(resultsAsUsers)
                        self.delegate?.didLoadNewResults(self, newResultsCount: resultsAsUsers.count)
                    }
                    
                    if resultsAsUsers.count < desiredCount {
                        self.delegate?.didLoadAllResultsForCriteria(self)
                    }
                }
            }
        }
    }
}

extension UserModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTableViewCell", forIndexPath: indexPath) as! SearchSuggestionTableViewCell
        return cell
    }
}