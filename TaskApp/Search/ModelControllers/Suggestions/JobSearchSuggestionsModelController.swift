//
//  JobSearchSuggestionsModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class JobSearchSuggestionsModelController: NSObject, QueryResultsTableViewDataSourceProtocol {
    var delegate: QueryResultsModelControllerDelegate?
    
    var keyword: String = ""
    
    private(set) var count: Int = 0
    
    func loadMore(desiredCount: Int) {
    }
}

extension JobSearchSuggestionsModelController : UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("JobSearchSuggestionTableViewCell", forIndexPath: indexPath) as! JobSearchSuggestionTableViewCell
        return cell
    }
}
