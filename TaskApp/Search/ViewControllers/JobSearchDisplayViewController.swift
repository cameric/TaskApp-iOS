//
//  JobSearchDisplayViewController.swift
//  JobApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class JobSearchDisplayViewController: SearchDisplayViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults = JobSearchResultsModelController()
        searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("JobSearchResultsViewController")
            as! IncrementalLoadingTableViewController
    
        searchSuggestions = JobSearchSuggestionsModelController()
        searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("JobSearchSuggestionsViewController")
            as! UITableViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
