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
    @IBOutlet weak var searchSuggestionTable: UITableView! {
        didSet {
            searchSuggestionTable.delegate = self
            searchSuggestionTable.dataSource = searchSuggestions
        }
    }
    
    weak var tabbedPageViewController: TabbedPageViewController!
    
    let categorySearchViewControllers =
    [
        UIStoryboard(name: "Search", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchViewController"),
        UIStoryboard(name: "Search", bundle: nil).instantiateViewControllerWithIdentifier("TaskSearchViewController"),
        UIStoryboard(name: "Search", bundle: nil).instantiateViewControllerWithIdentifier("JobSearchViewController")
    ]
    
    var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    let searchSuggestions = SearchSuggestionModelController()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        
        searchSuggestionTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        // Add search category pages
        categorySearchViewControllers.forEach({ (viewController: UIViewController) -> Void in
            let title = (viewController.title != nil) ? viewController.title! : ""
            tabbedPageViewController.addPage(viewController, title: title, animated: true)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TabbedPageViewControllerEmbedSegue" {
            tabbedPageViewController = segue.destinationViewController as? TabbedPageViewController
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
    }
}

// MARK: UITableViewDelegate methods
extension SearchViewController: UITableViewDelegate {
    
}