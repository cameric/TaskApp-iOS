//
//  IncrementalSearchViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

// TODO: Is this the best way to ensure this relationship?
protocol SearchResultTableViewDataSource: UITableViewDataSource, SearchResultModelControllerProtocol {
}

class IncrementalLoadingSearchViewController<DataSource: SearchResultTableViewDataSource>: UITableViewController {
    var source: DataSource!
    var resultsPerIncrement: Int = 10
    
    private let loadingCellTag: Int = 2147483648
    
    private let loadedAllResultsForCriteria: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if source != nil {
            tableView.dataSource = source!
        }
        // TODO: Else, throw something?
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedAllResultsForCriteria ? source.results.count : source.results.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < source.results.count {
            guard let cell = cellForRow(indexPath.row) else {
                // TODO: Throw something
            }
            return cell
        } else {
            guard let cell = loadingCell() else {
                // TODO: Throw something
            }
            cell.tag = loadingCellTag
            return cell
        }
    }
    
    func cellForRow(row: Int) -> UITableViewCell? {
        // TODO: Throw something
        return nil
    }
    
    func loadingCell() -> UITableViewCell? {
        // TODO: Throw something
        return nil
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.tag == loadingCellTag {
            source.loadMore(resultsPerIncrement)
        }
    }
}
