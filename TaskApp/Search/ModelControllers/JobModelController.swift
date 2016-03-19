//
//  JobModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class JobModelController: NSObject, SearchResultModelControllerProtocol {
    var results: [Job] = []
    var delegate: SearchResultModelControllerDelegate?
    
    func loadMore(desiredCount: Int) {
        
    }
}

extension JobModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JobTableViewCell", forIndexPath: indexPath) as! SearchSuggestionTableViewCell
        return cell
    }
}