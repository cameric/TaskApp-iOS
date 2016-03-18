//
//  SearchResultModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/16.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation
import AVOSCloud

protocol SearchResultsModelControllerProtocol {
    typealias ResultType: AVObject
    
    /*!
    * @brief The list of search results so far retrieved.
    */
    var results: [ResultType] { get }
    
    /*!
    * @brief Load up to `count` more results.
    * @discussion If there are fewer than `count` results remaining to load, as many will be loaded as possible.
    * @param count The number of additional results to load.
    */
    func loadMore(count: Int) // TODO: this should perhaps have a better name
    
    /*!
    * @brief Load as many results as necessary to bring the total.
    * @discussion If there are not enough results remaining to bring the total to `count`, as many will be loaded as possible.
    * @param count The total number of desired results.
    */
    func loadUntilTotalCountIs(totalCount: Int)
}

protocol SearchResultsModelControllerDelegate {
    /*!
     * @brief Called whenever the controller loads more than zero new results.
     */
    func didLoadNewResults<ModelController: SearchResultsModelControllerProtocol>(controller: ModelController, newResultsCount: Int)
    
    /*!
    * @brief Called whenever all possible results have already been loaded for the given search criteria.
    */
    func didLoadAllResultsForCriteria<ModelController: SearchResultsModelControllerProtocol>(controller: ModelController)
    
    /*!
    * @brief Called when the current search results may no longer match the given criteria (e.g. when the criteria are changed)
    */
    func didInvalidateCurrentResults<ModelController: SearchResultsModelControllerProtocol>(controller: ModelController)
}