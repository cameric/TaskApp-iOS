//
//  SearchResultsModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/16.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import AVOSCloud

protocol SearchResultModelControllerProtocol {
    typealias ResultType: AVObject
    
    var delegate: SearchResultModelControllerDelegate? { get set }
    
    /*!
    * @brief The list of search results so far retrieved.
    */
    var results: [ResultType] { get }
    
    /*!
    * @brief Load up to `desiredCount` more results.
    * @discussion If there are fewer than `count` results remaining to load, as many will be loaded as possible.
    * @param count The number of additional results to load.
    */
    func loadMore(desiredCount: Int) // TODO: this should perhaps have a better name
}

protocol SearchResultModelControllerDelegate {
    /*!
     * @brief Called whenever the controller loads more than zero new results.
     */
    func didLoadNewResults<ModelController: SearchResultModelControllerProtocol>(controller: ModelController, newResultsCount: Int)
    
    /*!
    * @brief Called whenever all possible results have already been loaded for the given search criteria.
    */
    func didLoadAllResultsForCriteria<ModelController: SearchResultModelControllerProtocol>(controller: ModelController)
    
    /*!
    * @brief Called when the current search results may no longer match the given criteria (e.g. when the criteria are changed)
    */
    func didInvalidateCurrentResults<ModelController: SearchResultModelControllerProtocol>(controller: ModelController)
}