//
//  PersonModelController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/17.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation
import AVOSCloud

/*!
 * NOTE! The following is a sample implementation that fakes network access by reading from a local array
 * This will be updated later when other structures have been put in place
 */

class PersonModelController : SearchResultsModelControllerProtocol {
    var delegate: SearchResultsModelControllerDelegate?
    private(set) var results: [Person] = []
    
    func loadMore(count: Int) {
        // Copy from the static array to fake a network query
        // Get the stop index -- either the end of the list of people or not
        let end = min(PersonModelController.peopleList.count, self.results.count+count)
        let retrieved = PersonModelController.peopleList[0..<end]
        self.results.appendContentsOf(retrieved)
        
        self.delegate?.didLoadNewResults(self, newResultsCount: retrieved.count)
    }

    func loadUntilTotalCountIs(count: Int) {
        let remainingCount = count - self.results.count
        if remainingCount > 0 {
            loadMore(remainingCount)
        }
    }
    
    // TODO: The network is complicated. Using this for now to fake a data source.
    private static let peopleList: [Person] = [
        Person(name: "陈星宇"),
        Person(name: "张正涵"),
        Person(name: "王喆沛"),
        Person(name: "周维宇"),
        Person(name: "蔡一清"),
        Person(name: "王尊严"),
        Person(name: "史珍香"),
        Person(name: "Prof. Wang"),
        Person(name: "Prof. Zhang"),
        Person(name: "Spencer"),
        Person(name: "Cam"),
        Person(name: "Michael"),
        Person(name: "William")
    ]
}