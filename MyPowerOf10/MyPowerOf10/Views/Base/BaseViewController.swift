//
//  BaseViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class BaseViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBar.tintColor = .potRed
    configureViewControllers()
  }
  
  // MARK: Private functions
  
  private func configureViewControllers() {
    let athleteSearchRouter = MyPoTRouter()
    athleteSearchRouter.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    let newTestViewController = UIViewController()
    newTestViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    
    let testViewController = UIViewController()
    testViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
    viewControllers = [athleteSearchRouter, newTestViewController, testViewController]
  }
  
}
