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
    @IBOutlet private var searchBar: UISearchBar!
    
    var keyword: String = ""
    
    // TODO:
    var resultsDataSource: IncrementalQueryTableViewDataSourceProtocol! = nil
    
    private var resultsTableViewController: UITableViewController! {
        didSet { resultsTableViewController.tableView.dataSource = resultsDataSource }
    }

    @IBOutlet var searchBarOverlayButton: UIButton!

    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.text = keyword
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
            presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
