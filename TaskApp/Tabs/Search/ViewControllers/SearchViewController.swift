//
//  SearchViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/13.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: Properties
    @IBOutlet private var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.backgroundImage = UIImage() // White background
        }
    }
    
    // TODO:
    var suggestionsDataSource: UITableViewDataSource! = nil
    
    private var suggestionsTableViewController: UITableViewController! {
        didSet {
            suggestionsTableViewController.tableView.dataSource = suggestionsDataSource
        }
    }
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO: Is this the right way to animate search bar selection? It's a bit stuttery
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedSearchSuggestionsTableSegue") {
            suggestionsTableViewController = segue.destinationViewController as! UITableViewController
        } else if (segue.identifier == "ShowSearchResultsSegue") {
            let searchResultsViewController = segue.destinationViewController as! SearchResultsViewController
            
            // Set the search results page to display the search text
            searchResultsViewController.keyword = (searchBar.text != nil) ? searchBar.text! : ""
        }
    }
}

// MARK: UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // Close self
        navigationController?.popViewControllerAnimated(false)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let keyword = searchBar.text where !keyword.isEmpty else {
            return
        }
        
        performSegueWithIdentifier("ShowSearchResultsSegue", sender: self)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // Update search results
    }
}