//
//  UserSearchDisplayViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class UserSearchDisplayViewController: SearchDisplayViewController {
    let results = UserSearchResultsModelController()
    let suggestions = UserSearchResultsModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsViewController.tableView.dataSource = results
        searchSuggestionsViewController.tableView.dataSource = suggestions
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
