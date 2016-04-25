//
//  HomeViewController.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/4/22.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties
    // TODO:
    var feedDataSource: IncrementalQueryTableViewDataSourceProtocol!
    
    var suggestionsTableViewController: IncrementalLoadingTableViewController! {
        didSet {
            suggestionsTableViewController.tableView.dataSource = feedDataSource
            suggestionsTableViewController.tableView.delegate = self
        }
    }
    
    var searchHeaderInitialHeight: CGFloat!
    @IBOutlet var searchHeaderHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var header: UIView!
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if (searchHeaderInitialHeight == nil) {
            searchHeaderInitialHeight = searchHeaderHeightConstraint.constant
        }
        
        searchBar.backgroundImage = UIImage()
        
        // Set this to false so that we don't get phantom calls to scrollViewDidScroll
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.15) {
            self.updateHeaderConstraints()
            self.view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EmbedFeedTableSegue") {
            suggestionsTableViewController = segue.destinationViewController as! IncrementalLoadingTableViewController
        }
    }
    
    func updateHeaderConstraints() {
        let yOffset = suggestionsTableViewController.tableView.contentOffset.y
        searchHeaderHeightConstraint.constant = searchHeaderInitialHeight - yOffset
    }
    
    @IBAction func searchButtonTapped(sender: UIButton) {
        // Shrink the search bar to the top and prevent scrolling temporarily to ensure no
        // weirdness happens during the animation
        searchHeaderHeightConstraint.constant = -1000
        suggestionsTableViewController.tableView.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.15, animations: {
            self.view.layoutIfNeeded()
        }) { (completed: Bool) in
            if completed {
                // Re-enable table view interaction and show the search interface
                self.suggestionsTableViewController.tableView.userInteractionEnabled = true
                self.performSegueWithIdentifier("ShowSearchSegue", sender: self)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderConstraints()
    }
}

// TODO: Fade segue, directly from http://netsplit.com/custom-ios-segues-transitions-and-animations-the-right-way
class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)
        -> NSTimeInterval
    {
        return 0.15
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        //let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        containerView!.addSubview(toVC!.view)
        toVC!.view.alpha = 0.0
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            toVC!.view.alpha = 1.0
            }, completion: { finished in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
        })
    }
}

class FadeInNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(
        navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController)
        -> UIViewControllerAnimatedTransitioning?
    {
        return FadeInAnimator()
    }
}