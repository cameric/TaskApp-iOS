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
    weak var tabbedPageViewController: TabbedPageViewController!
    
//    let SearchDisplayViewControllers: [SearchDisplayViewController] =
//    [
//    
//        UIStoryboard(name: "Search", bundle: nil)
//                .instantiateViewControllerWithIdentifier("UserSearchDisplayViewController")
//                as! UserSearchDisplayViewController,
//        UIStoryboard(name: "Search", bundle: nil)
//                .instantiateViewControllerWithIdentifier("TaskSearchDisplayViewController")
//                as! TaskSearchDisplayViewController,
//        UIStoryboard(name: "Search", bundle: nil)
//                .instantiateViewControllerWithIdentifier("JobSearchDisplayViewController")
//                as! JobSearchDisplayViewController,
//    ]
//    
//    private(set) var searchBar: UISearchBar! {
//        didSet {
//            searchBar.delegate = self
//        }
//    }
//    
//    // MARK: Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchBar = UISearchBar()
//        navigationItem.titleView = searchBar
//        
//        // Add search category pages
//        SearchDisplayViewControllers.forEach({ (viewController: UIViewController) -> Void in
//            let title = (viewController.title != nil) ? viewController.title! : ""
//            tabbedPageViewController.addPage(viewController, title: title, animated: true)
//        })
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "TabbedPageViewControllerEmbedSegue" {
//            tabbedPageViewController = segue.destinationViewController as? TabbedPageViewController
//        }
//    }
}

// MARK: UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(true, animated: true)
//    }
//    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        searchBar.setShowsCancelButton(false, animated: true)
//        displaySearchResults(false)
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        displaySearchResults(true)
//    }
//    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        updateSearchKeyword(searchText)
//    }
//    
//    private func updateSearchKeyword(keyword: String) {
//        SearchDisplayViewControllers.forEach { (vc: UIViewController) in
//            if let searchDisplayViewController = vc as? SearchDisplayViewController {
//                searchDisplayViewController.keyword = keyword
//            }
//        }
//    }
//    
//    private func displaySearchResults(show: Bool) {
//        SearchDisplayViewControllers.forEach { (vc: UIViewController) in
//            if let searchDisplayViewController = vc as? SearchDisplayViewController {
//                searchDisplayViewController.showSearchResults = show
//            }
//        }
//    }
}