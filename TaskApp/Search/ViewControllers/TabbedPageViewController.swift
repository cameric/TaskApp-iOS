//
//  TabbedPageViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/19.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TabbedPageViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UISegmentedControl! {
        didSet {
            tabBar.addTarget(self, action: #selector(TabbedPageViewController.tabBarSelectionChanged(_:)), forControlEvents: .ValueChanged)
        }
    }
    weak var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.delegate = self
            pageViewController.dataSource = self
        }
    }
    
    private(set) var pages: [UIViewController] = []
    private(set) var currentPageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pages.count > 0 {
            scrollToPage(0, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PageViewControllerEmbedSegue" {
            pageViewController = segue.destinationViewController as? UIPageViewController
        }
    }
    
    @IBAction func tabBarSelectionChanged(segmentedControl: UISegmentedControl) {
        scrollToPage(segmentedControl.selectedSegmentIndex, animated: true)
    }
    
    func scrollToPage(index: Int, animated: Bool) {
        let direction: UIPageViewControllerNavigationDirection = (index >= currentPageIndex) ? .Forward : .Reverse
        
        if index < pages.count {
            let targetPage = pages[index]
            pageViewController.setViewControllers([targetPage], direction: direction, animated: animated) { (animationFinished: Bool) -> Void in
                // TODO: It seems to be the case animationFinished == false just means the animation was skipped,
                // not that the action was canceled, so we don't need to take it into account. Is this true?
                self.currentPageIndex = index
            }
        }
        // TODO: Throw something if the page is OOB?
    }
    
    func addPage(page: UIViewController, title: String, animated: Bool) {
        pages.append(page)
        
        // Since the number of pages starts at zero, supposing that all pages are added
        // through this function, numberOfSegments is at most one less than pages.count
        if tabBar.numberOfSegments < pages.count {
            // Insert a new segment
            tabBar.insertSegmentWithTitle(title, atIndex: tabBar.numberOfSegments, animated: animated)
        } else {
            // Set the title of an existing segment
            tabBar.setTitle(title, forSegmentAtIndex: pages.count-1)
        }
        
        // If this is the first page added, scroll to it
        if pages.count == 1 {
            scrollToPage(0, animated: true)
        }
    }
}

// MARK: UIPageViewControllerDelegate methods
extension TabbedPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController) {
            let nextIndex = (index + 1) % pages.count
            return pages[nextIndex]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController) {
            let prevIndex = (index > 0) ? index - 1 :  pages.count - 1
            return pages[prevIndex]
        } else {
            return nil
        }
    }
}

// MARK: UIPageViewControllerDelegate methods
extension TabbedPageViewController: UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // TODO: Is a direct `return` okay? It seems lacking a page to transition to isn't really an error
            // (Really, I think it's guaranteed never to happen. But if it does, it's recoverable.)
            guard let destinationViewController = pageViewController.viewControllers?.last else {
                return
            }
            guard let index = pages.indexOf(destinationViewController) else {
                return
            }
            
            // TODO: The following does not animate. Make this prettier later.
            tabBar.selectedSegmentIndex = index
            currentPageIndex = index
        }
    }
}