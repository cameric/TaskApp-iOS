//
//  IncrementalQueryTableViewDataSourceProtocol.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/16.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud

protocol IncrementalQueryModelControllerProtocol {
    var delegate: IncrementalQueryModelControllerDelegate? { get set }
    
    /*!
    * @brief Load up to `desiredCount` more results.
    * @discussion If there are fewer than `count` results remaining to load, as many will be loaded as possible.
    * @param count The number of additional results to load.
    */
    func loadMore(desiredCount: Int)
}

protocol IncrementalQueryTableViewDataSourceProtocol: IncrementalQueryModelControllerProtocol, UITableViewDataSource {
}

protocol IncrementalQueryModelControllerDelegate {
    /*!
     * @brief Called whenever the controller loads more than zero new results.
     */
    func didLoadNewResults(controller: IncrementalQueryModelControllerProtocol, newResultsCount: Int)
    
    /*!
    * @brief Called whenever all possible results have already been loaded for the given search criteria.
    */
    func didLoadAllResultsForCriteria(controller: IncrementalQueryModelControllerProtocol)
    
    /*!
    * @brief Called when the current search results may no longer match the given criteria (e.g. when the criteria are changed)
    */
    func didInvalidateCurrentResults(controller: IncrementalQueryModelControllerProtocol)
    
    /*!
    * @brief Called when loading new results fails due to an error (e.g. network down)
    */
    func didFailToLoadNewResults(controller: IncrementalQueryModelControllerProtocol, error: NSError)
}