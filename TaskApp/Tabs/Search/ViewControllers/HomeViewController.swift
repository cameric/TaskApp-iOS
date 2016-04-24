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
        didSet { suggestionsTableViewController.tableView.dataSource = feedDataSource }
    }
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedFeedTableSegue") {
            suggestionsTableViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }
}
