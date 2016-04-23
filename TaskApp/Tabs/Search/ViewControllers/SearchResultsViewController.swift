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
    @IBOutlet var searchBar: UISearchBar!
    
    var resultsDataSource: IncrementalQueryTableViewDataSourceProtocol! = nil
    
    private var resultsTableViewController: UITableViewController! {
        didSet { resultsTableViewController.tableView.dataSource = resultsDataSource }
    }

    @IBOutlet var searchBarOverlayButton: UIButton!

    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedSearchResultsTableSegue") {
            resultsTableViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }
    
    @IBAction func searchBarOverlayButtonPressed(sender: UIButton) {
        if (sender == searchBarOverlayButton) {
            // Close self
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
