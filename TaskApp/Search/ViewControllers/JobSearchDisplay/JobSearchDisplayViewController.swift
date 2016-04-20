//
//  JobSearchDisplayViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class JobSearchDisplayViewController: SearchDisplayViewController {
    class func initFromStoryboard() -> JobSearchDisplayViewController
    {
        let searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("JobSearchResultsViewController")
            as! IncrementalLoadingTableViewController
        searchResultsViewController.tableView.dataSource = JobSearchResultsModelController()
        
        let searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("JobSearchSuggestionsViewController")
            as! UITableViewController
        searchSuggestionsViewController.tableView.dataSource = JobSearchSuggestionsModelController()

        let jobSearchDisplayViewController = SearchDisplayViewController.initFromStoryboard(
            "Search", identifier: "JobSearchDisplayViewController",
            searchResultsViewController: searchResultsViewController,
            searchSuggestionsViewController: searchSuggestionsViewController)
        
        return jobSearchDisplayViewController as! JobSearchDisplayViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
