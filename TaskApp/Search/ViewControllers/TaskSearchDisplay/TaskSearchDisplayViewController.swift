//
//  TaskSearchDisplayViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TaskSearchDisplayViewController: SearchDisplayViewController {
   class func initFromStoryboard() -> TaskSearchDisplayViewController
    {
        let searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("TaskSearchResultsViewController")
            as! IncrementalLoadingTableViewController
        searchResultsViewController.tableView.dataSource = TaskSearchResultsModelController()
        
        let searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("TaskSearchSuggestionsViewController")
            as! UITableViewController
        searchSuggestionsViewController.tableView.dataSource = TaskSearchSuggestionsModelController()

        let taskSearchDisplayViewController = SearchDisplayViewController.initFromStoryboard(
            "Search", identifier: "TaskSearchDisplayViewController",
            searchResultsViewController: searchResultsViewController,
            searchSuggestionsViewController: searchSuggestionsViewController)
        
        return taskSearchDisplayViewController as! TaskSearchDisplayViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
