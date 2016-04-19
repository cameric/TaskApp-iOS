//
//  UserSearchDisplayViewController.swift
//  UserApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class UserSearchDisplayViewController: SearchDisplayViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults = UserSearchResultsModelController()
        searchResultsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("UserSearchResultsViewController")
            as! IncrementalLoadingTableViewController
    
        searchSuggestions = TaskSearchSuggestionsModelController()
        searchSuggestionsViewController = UIStoryboard(name: "Search", bundle: nil)
            .instantiateViewControllerWithIdentifier("UserSearchSuggestionsViewController")
            as! UITableViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
