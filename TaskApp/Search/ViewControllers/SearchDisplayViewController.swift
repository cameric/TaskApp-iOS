//
//  SearchResultsViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

extension UIViewController {
    class func initFromStoryboard(name: String, identifier: String) -> UIViewController
    {
        return UIStoryboard(name: name, bundle: nil).instantiateViewControllerWithIdentifier(identifier)
    }
}

class SearchDisplayViewController: UIViewController {
    class func initFromStoryboard(
        name: String, identifier: String,
        searchResultsViewController: IncrementalLoadingTableViewController,
        searchSuggestionsViewController: UITableViewController)
        -> SearchDisplayViewController
    {
        let searchDisplayViewController =
            UIViewController.initFromStoryboard(name, identifier: identifier) as! SearchDisplayViewController
        searchDisplayViewController.searchResultsViewController = searchResultsViewController
        searchDisplayViewController.searchSuggestionsViewController = searchSuggestionsViewController
        
        return searchDisplayViewController
    }
    
    @IBOutlet weak var tableContainerView: UIView!
    
    var keyword: String = ""
    var showSearchResults: Bool = false {
        didSet {
            updateContainedViewController()
        }
    }
    
    private var searchResultsViewController: IncrementalLoadingTableViewController!
    private var searchSuggestionsViewController: UITableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateContainedViewController() {
    }
}
