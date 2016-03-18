//
//  SearchSuggestionModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation
import UIKit

// TODO: does this NSOBject inheritance need to be here? It's for the tableviewdatasource
class SearchSuggestionModelController : NSObject, SearchResultsModelControllerProtocol {
    private(set) var results: [SearchSuggestion] = []
    var delegate: SearchResultsModelControllerDelegate?
    
    func loadMore(count: Int) {
        // Copy from the static array to fake a network query
        self.results = SearchSuggestionModelController.suggestionsList
    }
    
    // TODO: The network is complicated. Using this for now to fake a data source.
    private static let suggestionsList: [SearchSuggestion] = [
        SearchSuggestion(title: "陈星宇"),
        SearchSuggestion(title: "张正涵"),
        SearchSuggestion(title: "王喆沛"),
        SearchSuggestion(title: "周维宇"),
        SearchSuggestion(title: "蔡一清"),
        SearchSuggestion(title: "王尊严"),
        SearchSuggestion(title: "史珍香"),
        SearchSuggestion(title: "Prof. Wang"),
        SearchSuggestion(title: "Prof. Zhang"),
        SearchSuggestion(title: "Spencer"),
        SearchSuggestion(title: "Cam"),
        SearchSuggestion(title: "Michael"),
        SearchSuggestion(title: "William")
    ]
}

extension SearchSuggestionModelController : UITableViewDataSource {
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchSuggestionTableViewCell", forIndexPath: indexPath) as! SearchSuggestionTableViewCell
        cell.titleLabel.text = self.results[indexPath.row].title
        return cell
    }
}