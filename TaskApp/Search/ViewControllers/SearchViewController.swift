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
    @IBOutlet weak var categoryBar: UISegmentedControl!

    weak var categoryPageController: UIPageViewController! {
        didSet {
            categoryPageController.dataSource = self
        }
    }
    
    let categoryViewControllers = [
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
        
        searchSuggestions.loadMore(10)
        
        searchSuggestionTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    override func viewDidAppear(animated: Bool) {
        if let firstCategoryVC = categoryViewControllers.first {
            categoryPageController.setViewControllers([firstCategoryVC], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CategoryPageControllerEmbedSegue" {
            categoryPageController = segue.destinationViewController as? UIPageViewController
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

// MARK: UIPageViewControllerDelegate methods
extension SearchViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = categoryViewControllers.indexOf(viewController) {
            let nextIndex = (index + 1) % categoryViewControllers.count
            return categoryViewControllers[nextIndex]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = categoryViewControllers.indexOf(viewController) {
            let prevIndex = max(0, (index - 1) % categoryViewControllers.count)
            return categoryViewControllers[prevIndex]
        } else {
            return nil
        }
    }
}