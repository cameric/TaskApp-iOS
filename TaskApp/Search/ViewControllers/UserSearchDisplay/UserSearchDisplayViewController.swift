//
//  UserSearchDisplayViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class UserSearchDisplayViewController: SearchDisplayViewController {
   class func initFromStoryboard() -> UserSearchDisplayViewController
    {
        let searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("UserSearchResultsViewController")
            as! IncrementalLoadingTableViewController
        searchResultsViewController.tableView.dataSource = UserSearchResultsModelController()
        
        let searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("UserSearchSuggestionsViewController")
            as! UITableViewController
        searchSuggestionsViewController.tableView.dataSource = UserSearchSuggestionsModelController()

        let userSearchDisplayViewController = SearchDisplayViewController.initFromStoryboard(
            "Search", identifier: "UserSearchDisplayViewController",
            searchResultsViewController: searchResultsViewController,
            searchSuggestionsViewController: searchSuggestionsViewController)
        
        return userSearchDisplayViewController as! UserSearchDisplayViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
