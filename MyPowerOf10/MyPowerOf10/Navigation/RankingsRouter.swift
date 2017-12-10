//
//  RankingsRouter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class RankingsRouter: UINavigationController {
  
  private let dataStore: DataStoreType
  
  init(dataStore: DataStoreType = DataStore()) {
    self.dataStore = dataStore
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    populateViewControllers()
  }
  
  private func style() { //TODO - move this to global function
    navigationBar.tintColor = .potRed
    if #available(iOS 11.0, *) {
      navigationBar.prefersLargeTitles = true
      navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
    }
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
  }
  
  private func populateViewControllers() {
    let rankingsSearchPresenter = RankingsSearchPresenter()
    let rankingsSearchViewController = RankingsSearchViewController(delegate: self, presenter: rankingsSearchPresenter)
    viewControllers = [rankingsSearchViewController]
  }
  
}

// MARK: - RankingsSearchViewControllerDelegate

extension RankingsRouter: RankingsSearchViewControllerDelegate {
  
}
