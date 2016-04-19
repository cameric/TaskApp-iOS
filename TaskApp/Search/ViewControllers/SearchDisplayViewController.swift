//
//  SearchResultsViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class SearchDisplayViewController: UIViewController {
    var keyword: String = "" {
        didSet {
            updateSearchParameters()
            updateSearchDisplay()
        }
    }
    var showSearchResults: Bool = false {
        didSet {
            updateSearchParameters()
            updateSearchDisplay()
        }
    }
    
    var searchSuggestions: QueryResultsTableViewDataSourceProtocol!
    var searchResults: QueryResultsTableViewDataSourceProtocol!
    
    var searchResultsViewController: IncrementalLoadingTableViewController! {
        didSet {
            searchResultsViewController.tableView.dataSource = searchResults
        }
    }
    var searchSuggestionsViewController: UITableViewController! {
        didSet {
            searchSuggestionsViewController.tableView.dataSource = searchSuggestions
            // We want the search results VC to render over the main table view
            searchSuggestionsViewController.definesPresentationContext = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Avoid needlessly updating the search parameters of a non-visible VC
    private func updateSearchParameters() {
        if (showSearchResults) {
            searchResults.keyword = keyword
        } else {
            searchSuggestions.keyword = keyword
        }
    }
    
    private func updateSearchDisplay() {
        if (showSearchResults && !keyword.isEmpty) {
            searchSuggestionsViewController.presentViewController(
                searchResultsViewController, animated: false, completion: nil)
        } else {
            searchSuggestionsViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
