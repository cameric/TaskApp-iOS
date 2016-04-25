//
//  HomeViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/22.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties
    // TODO:
    var feedDataSource: IncrementalQueryTableViewDataSourceProtocol!
    
    var suggestionsTableViewController: IncrementalLoadingTableViewController! {
        didSet {
            suggestionsTableViewController.tableView.dataSource = feedDataSource
            suggestionsTableViewController.tableView.delegate = self
        }
    }
    
    var searchHeaderInitialHeight: CGFloat!
    @IBOutlet var searchHeaderHeightConstraint: NSLayoutConstraint!
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (searchHeaderInitialHeight == nil) {
            searchHeaderInitialHeight = searchHeaderHeightConstraint.constant
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.15) {
            self.updateHeaderConstraints()
            self.view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedFeedTableSegue") {
            suggestionsTableViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }
    
    func updateHeaderConstraints() {
        let yOffset = suggestionsTableViewController.tableView.contentOffset.y
        searchHeaderHeightConstraint.constant = searchHeaderInitialHeight - yOffset
    }
    
    @IBAction func searchButtonTapped(sender: UIButton) {
        // Shrink the search bar to the top and prevent scrolling temporarily to ensure no
        // weirdness happens during the animation
        searchHeaderHeightConstraint.constant = -1000
        suggestionsTableViewController.tableView.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.15, animations: {
            self.view.layoutIfNeeded()
        }) { (completed: Bool) in
            if completed {
                // Re-enable table view interaction and show the search interface
                self.suggestionsTableViewController.tableView.userInteractionEnabled = true
                self.performSegueWithIdentifier("ShowSearchSegue", sender: self)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderConstraints()
    }
}