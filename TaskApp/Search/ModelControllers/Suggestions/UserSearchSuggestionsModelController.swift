//
//  UserSearchSuggestionsModelController.swift
//  UserApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class UserSearchSuggestionsModelController: NSObject, QueryResultsTableViewDataSourceProtocol {
    var delegate: QueryResultsModelControllerDelegate?
    
    var keyword: String = ""
    
    private(set) var count: Int = 0
    
    func loadMore(desiredCount: Int) {
    }
}

extension UserSearchSuggestionsModelController : UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UserSearchSuggestionTableViewCell", forIndexPath: indexPath) as! UserSearchSuggestionTableViewCell
        return cell
    }
}
