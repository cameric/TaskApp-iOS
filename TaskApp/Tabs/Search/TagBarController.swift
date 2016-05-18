//
//  TagBarController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/5/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import Foundation

class TagBarController: NSObject, TagBarDelegate {
    @IBOutlet var tagBar: TagBar! {
        didSet { tagBar.delegate = self }
    }
    private var stack: [Tree<String>] = []
    
    var tagTree: Tree<String>? {
        get {
            return stack.first
        }
        set {
            if let root = newValue {
                stack = [root]
            } else {
                stack = []
            }
            updateDisplay()
        }
    }
    
    var selectedTags: [String] {
        get {
            // Build up the tag list excluding the root tag
            var tagList = self.stack.dropFirst().map(
                { (node: Tree<String>) -> String in
                    return node.value
                })
            // Add the bottom-level tag (whose node is not on the stack)
            if let bottomLevelTag = tagBar.selectedTag {
                tagList.append(bottomLevelTag)
            }
            
            return tagList
        }
    }
    
    func drillDown(index: Int) {
        guard let root = stack.last else {
            return // Throw?
        }
        stack.append(root.children[index])
        updateDisplay()
    }
    
    func goBack() {
        if stack.count > 1 {
            stack.removeLast()
            updateDisplay()
        }
    }
    
    private func updateDisplay() {
        tagBar.showsBackButton = (stack.count > 1)
        
        // This assumes the stack has at least one node
        if let currentRoot = stack.last {
            tagBar.tags = currentRoot.children.map({ (node: Tree<String>) -> String in
                return node.value
            })
        } else {
            tagBar.tags = []
        }
    }
    
    func didTapBack(sender: TagBar) {
        goBack()
        print("Tag list is now", selectedTags.description)
    }
    
    func didTapTag(sender: TagBar, index: Int) {
        guard let node = stack.last?.children[index] else {
            return // Throw?
        }
        
        // Drill down if a node has children.
        if node.children.count > 0 {
            drillDown(index)
        }
        print("Tag list is now", selectedTags.description)
    }
}