//
//  IncrementalQueryProtocol.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/16.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud

protocol IncrementalQueryProtocol {
    var delegate: IncrementalQueryDelegate? { get set }
    
    /*!
    * @brief Load up to `desiredCount` more results.
    * @discussion If there are fewer than `count` results remaining to load, only that many will be loaded.
    * @param count The number of additional results to load.
    */
    func loadMore(desiredCount: Int)
    
    // The number of results currently loaded
    var count: Int { get }
}

protocol IncrementalQueryTableViewDataSourceProtocol: IncrementalQueryProtocol, UITableViewDataSource {
}

protocol IncrementalQueryDelegate {
    /*!
     * @brief Called whenever the controller loads more than zero new results.
     */
    func didLoadNewResults(controller: IncrementalQueryProtocol, newResultsCount: Int)
    
    /*!
    * @brief Called whenever all possible results have already been loaded for the given search criteria.
    */
    func didLoadAllResultsForCriteria(controller: IncrementalQueryProtocol)
    
    /*!
    * @brief Called when the current search results may no longer match the given criteria (e.g. when the criteria are changed)
    */
    func didInvalidateCurrentResults(controller: IncrementalQueryProtocol)
    
    /*!
    * @brief Called when loading new results fails due to an error (e.g. network down)
    */
    func didFailToLoadNewResults(controller: IncrementalQueryProtocol, error: NSError)
}