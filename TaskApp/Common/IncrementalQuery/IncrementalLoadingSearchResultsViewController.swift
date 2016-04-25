//
//  IncrementalSearchViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class IncrementalLoadingTableViewController: UITableViewController, IncrementalQueryDelegate {
    /// The data source for the table view.
    var source: IncrementalQueryTableViewDataSourceProtocol! {
        didSet {
            source.delegate = self
            tableView.dataSource = self
        }
    }
    
    /// The number of new results to load every time the user scrolls to the bottom of the table view
    var resultsPerLoad: Int = 20
    
    /// Whether or not the source has already given us all results for the search criteria
    private var loadedAllResultsForCriteria: Bool = true
    
    /// Whether or not the source encountered an error on the last load attempt
    private var loadEncounteredError: Bool = false
    
    private let loadingCellTag = 4294967295
    private let errorCellTag = 4294967296
    
    /**
        Returns the number of sections in the table view. Always 1.
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
        Returns the number of cells in the table view.
     
        - Returns: The number of search results, plus one (for the loading cell) if there are
        still results to load or an error occurred while loading results.
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard source != nil else {
            return 0
        }
        
        if loadedAllResultsForCriteria || loadEncounteredError {
            return source.count + 1
        } else {
            return source.count
        }
    }
    
    /**
        Returns the cell at the given index path in the table view.
     
        - Returns: The cell at the given index path, which is a result cell except for the case in which
        `indexPath.row` is equal to the number of search results. In this case, a loading cell is returned,
        unless an error has occurred while loading results, in which case an error cell is returned.
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < source.count {
            return resultCellForRow(indexPath.row)
        } else if loadEncounteredError {
            return errorCell()
        } else {
            return loadingCell()
        }
    }
    
    /**
        Returns a formatted result cell corresponding to the `row`th search result.
     
        By default, this function returns a generic placeholder cell. This method
        should be overridden in subclasses.
     
        - Parameter row: The row of the cell to return.
     
        - Returns: A result cell, formatted using data from the `row`th search result.
     */
    func resultCellForRow(row: Int) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        let label = UILabel()
        label.text = "Result Cell Placeholder"
        cell.addSubview(label)
        
        label.centerXAnchor.constraintEqualToAnchor(cell.contentView.centerXAnchor)
        label.centerYAnchor.constraintEqualToAnchor(cell.contentView.centerYAnchor)
        
        return cell
    }
    
    /**
        Returns a cell that displays a loading indicator.
     
        - Returns: A cell that displays a loading indicator
     */
    func loadingCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.tag = loadingCellTag
        
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        cell.addSubview(loadingIndicator)
        
        loadingIndicator.centerXAnchor.constraintEqualToAnchor(cell.contentView.centerXAnchor)
        loadingIndicator.centerYAnchor.constraintEqualToAnchor(cell.contentView.centerYAnchor)
        loadingIndicator.startAnimating()
        
        return cell
    }
    
    /**
        Returns a cell that indicates an error has occured.
     
        When clicked, this cell will retry loading the most recent set of results.
     
        - Returns: A cell that indicates an error has occurred.
     */
    func errorCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.tag = errorCellTag
        
        let label = UILabel()
        label.text = "An error occurred. Tap to retry."
        cell.addSubview(label)
        
        label.centerXAnchor.constraintEqualToAnchor(cell.contentView.centerXAnchor)
        label.centerYAnchor.constraintEqualToAnchor(cell.contentView.centerYAnchor)
        
        return cell
    }
    
    /**
        Called when a cell is about to be displayed. If the cell is the loading cell
        (which appears in the last row at the index equal to the number of currently loaded
        search results), begin loading a new page of results.
     */
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.tag == loadingCellTag {
            source.loadMore(resultsPerLoad)
        }
    }
    
    /**
        Called when a cell is selected. If the cell is the error cell, selecting it
        retries loading search results.
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        if cell.tag == errorCellTag {
            // TODO: It may be necessary to manually reload the tableview here.
            loadEncounteredError = false
            source.loadMore(resultsPerLoad)
        }
    }
    
    func didLoadNewResults(controller: IncrementalQueryProtocol, newResultsCount: Int) {
        // Don't need to do anything here -- the table view updates automatically
    }
    
    /// Called when all available search results have been loaded.
    func didLoadAllResultsForCriteria(controller: IncrementalQueryProtocol) {
        loadedAllResultsForCriteria = true
    }
    
    /// Called when the current search results are no longer valid.
    func didInvalidateCurrentResults(controller: IncrementalQueryProtocol) {
        // TODO: How to handle quick, repeated criteria changes?
        loadedAllResultsForCriteria = false
        loadEncounteredError = false
    }
    
    /// Called when loading new results fails due to an error
    func didFailToLoadNewResults(controller: IncrementalQueryProtocol, error: NSError) {
        loadEncounteredError = true
    }
}
