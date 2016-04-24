//
//  SearchViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/13.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: Properties
    weak var tabbedPageViewController: TabbedPageViewController!
    
    @IBOutlet private var searchBar: UISearchBar! {
        didSet { searchBar.delegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
}