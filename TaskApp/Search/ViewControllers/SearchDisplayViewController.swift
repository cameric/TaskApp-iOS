//
//  SearchResultsViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class AttachSegue: UIStoryboardSegue {
    override func perform() {
        // Don't do anything
    }
}

class SearchDisplayViewController: UIViewController {
    @IBOutlet weak var tableContainerView: UIView!
    
    var keyword: String = ""
    var showSearchResults: Bool = false {
        didSet {
            updateContainedViewController()
        }
    }
    
    private(set) var searchResultsViewController: IncrementalLoadingTableViewController!
    private(set) var searchSuggestionsViewController: UITableViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SuggestionsEmbedSegue") {
            searchSuggestionsViewController = segue.destinationViewController as! UITableViewController
        } else if (segue.identifier == "ResultsAttachSegue") {
            searchResultsViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Immediately get the results view controller
        performSegueWithIdentifier("ResultsAttachSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateContainedViewController() {
        if (showSearchResults) {
            searchSuggestionsViewController.presentViewController(searchResultsViewController, animated: true, completion: nil)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
