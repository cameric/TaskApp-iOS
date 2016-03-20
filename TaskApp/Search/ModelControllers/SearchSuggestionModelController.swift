//
//  SearchSuggestionModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

// TODO: does this NSOBject inheritance need to be here? It's for the tableviewdatasource
class SearchSuggestionModelController : NSObject, SearchResultModelControllerProtocol {
    private(set) var results: [SearchSuggestion] = []
    var delegate: SearchResultModelControllerDelegate?
    
    func loadMore(desiredCount: Int) {
        // TODO: params
        AVCloud.callFunctionInBackground("getSearchSuggestionsForKeyword", withParameters: nil) { (response: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                //TODO: delegate?.didFailToLoadNewResults(self, error)
            } else {
                if let resultsAsSearchSuggestions = response as? [SearchSuggestion] {
                    if resultsAsSearchSuggestions.count > 0 {
                        self.results.appendContentsOf(resultsAsSearchSuggestions)
                        self.delegate?.didLoadNewResults(self, newResultsCount: resultsAsSearchSuggestions.count)
                    }
                    
                    if resultsAsSearchSuggestions.count < desiredCount {
                        self.delegate?.didLoadAllResultsForCriteria(self)
                    }
                }
            }
        }
    }
}

extension SearchSuggestionModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchSuggestionTableViewCell", forIndexPath: indexPath) as! SearchSuggestionTableViewCell
        cell.titleLabel.text = results[indexPath.row].title
        return cell
    }
}