//
//  Tree.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/5/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation

struct Tree<Element: Comparable> {
    let value: Element
    var children: [Tree] = []
    
    init(value: Element) {
        self.value = value
    }
    
    func find(value: Element, maxDepth: Int) -> Tree<Element>? {
        if (self.value == value) {
            // Root has the value
            return self
        } else if (maxDepth > 0) {
            // Search children
            for child in children {
                if let found = child.find(value, maxDepth: maxDepth-1) {
                    // A child has the value
                    return found
                }
            }
        }
        // Not found up to the specified depth
        return nil
    }
}