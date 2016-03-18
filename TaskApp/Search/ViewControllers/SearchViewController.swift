//
//  SearchViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/13.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchSuggestionTable: UITableView!
    @IBOutlet weak var categoryBar: UISegmentedControl!
    @IBOutlet weak var categoryPages: UIPageViewController!
    
    var searchBar: UISearchBar!
    var searchSuggestions: SearchSuggestionModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar
        
        self.searchSuggestions = SearchSuggestionModelController()
        self.searchSuggestions.loadMore(10)
        
        self.searchSuggestionTable.delegate = self
        self.searchSuggestionTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.searchSuggestionTable.dataSource = self.searchSuggestions
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {
    
}