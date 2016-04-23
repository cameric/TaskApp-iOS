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
    @IBOutlet var searchBar: UISearchBar! {
        didSet { searchBar.delegate = self }
    }
    
    // TODO:
    var suggestionsDataSource: UITableViewDataSource! = nil
    
    private var suggestionsTableViewController: UITableViewController! {
        didSet { suggestionsTableViewController.tableView.dataSource = suggestionsDataSource }
    }
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedSearchSuggestionsTableSegue") {
            suggestionsTableViewController = segue.destinationViewController as! UITableViewController
        } else if (segue.identifier == "ShowSearchResultsSegue") {
            let searchResultsViewController = segue.destinationViewController as! SearchResultsViewController
            searchResultsViewController.searchBar.text = searchBar.text
        }
    }
}

// MARK: UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        
        // Close self
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        performSegueWithIdentifier("ShowSearchResultsSegue", sender: self)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
}