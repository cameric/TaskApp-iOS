//
//  TaskSearchDisplayViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TaskSearchDisplayViewController: SearchDisplayViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults = TaskSearchResultsModelController()
        searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("TaskSearchResultsViewController")
            as! IncrementalLoadingTableViewController
    
        searchSuggestions = TaskSearchSuggestionsModelController()
        searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("TaskSearchSuggestionsViewController")
            as! UITableViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
