//
//  SearchResultsViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/22.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    // MARK: Properties
    @IBOutlet private var searchBar: UISearchBar! {
        didSet { searchBar.backgroundImage = UIImage() } // White background
    }
    @IBOutlet private var tagBarController: TagBarController!
    
    var keyword: String = ""
    
    // TODO:
    //var resultsDataSource: SearchResultsDataSourceProtocol! = nil
    var resultsDataSource: IncrementalQueryTableViewDataSourceProtocol! = nil
    
    private var resultsTableViewController: UITableViewController! {
        didSet { resultsTableViewController.tableView.dataSource = resultsDataSource }
    }

    @IBOutlet var searchBarOverlayButton: UIButton!

    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.text = keyword
        
        // TODO: Temporary tag tree test
        var tree = Tree<String>(value: "root")
        var ios = Tree<String>(value: "ios")
        ios.children.append(Tree<String>(value: "swift"))
        ios.children.append(Tree<String>(value: "objc"))
        tree.children.append(ios)
        tree.children.append(Tree<String>(value: "android"))
        tree.children.append(Tree<String>(value: "windows"))
        tagBarController.tagTree = tree
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedSearchResultsTableSegue") {
            resultsTableViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }
    
    // MARK: UIButton related
    @IBAction func searchBarOverlayButtonPressed(sender: UIButton) {
        if (sender == searchBarOverlayButton) {
            // Close self
            navigationController?.popViewControllerAnimated(false)
        }
    }
}
