//
//  TabBarWithButtonControllerDelegate.swift
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/14.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class TabBarWithCenterButtonControllerDelegate: NSObject, UITabBarControllerDelegate {
    static let unselectableTag = 1337
    
    @objc func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == TabBarWithCenterButtonControllerDelegate.unselectableTag {
            return false;
        }
        return true;
    }
}
