//
//  TagBar.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/5/18.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

protocol TagBarDelegate {
    func didTapTag(sender: TagBar, index: Int);
    func didTapBack(sender: TagBar);
}

class TagBar: UIView {
    var delegate: TagBarDelegate?
    
    @IBOutlet var tagButtons: UISegmentedControl! {
        didSet {
            tagButtons.addTarget(self, action: #selector(TagBar.didTapTag), forControlEvents: .ValueChanged)
        }
    }
    var tags: [String] = [] {
        didSet {
            updateDisplay()
        }
    }
    var selectedTag: String? {
        get {
            guard tagButtons.selectedSegmentIndex != -1 else {
                return nil
            }
            return tags[tagButtons.selectedSegmentIndex]
        }
    }

    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(TagBar.didTapBack), forControlEvents: .TouchUpInside)
        }
    }
    var showsBackButton: Bool = true {
        didSet {
            backButton.hidden = !showsBackButton
            tagButtonsToBackButtonConstraint.active = showsBackButton
        }
    }
    
    @IBOutlet var loadingIndicator: UIView!
    var showsLoadingIndicator: Bool = true {
        didSet { loadingIndicator.hidden = !showsLoadingIndicator }
    }
    
    @IBOutlet var tagButtonsToBackButtonConstraint: NSLayoutConstraint!
    
    private func updateDisplay() {
        if tags.count < 2 {
            showsLoadingIndicator = true
        } else {
            tagButtons.removeAllSegments()
            tags.forEach { (tag: String) in
                tagButtons.insertSegmentWithTitle(tag, atIndex: tagButtons.numberOfSegments, animated: false)
            }
            
            showsLoadingIndicator = false
        }
    }
    
    @objc private func didTapTag(sender: UISegmentedControl) {
        delegate?.didTapTag(self, index: sender.selectedSegmentIndex)
    }
    
    @objc private func didTapBack(sender: UIButton) {
        delegate?.didTapBack(self)
    }
}
