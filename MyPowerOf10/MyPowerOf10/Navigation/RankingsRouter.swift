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
  
  private func populateViewControllers() {
    let rankingsSearchPresenter = RankingsSearchPresenter()
    let rankingsSearchViewController = RankingsSearchViewController(delegate: self, presenter: rankingsSearchPresenter)
    viewControllers = [rankingsSearchViewController]
  }
  
}

// MARK: - RankingsSearchViewControllerDelegate

extension RankingsRouter: RankingsSearchViewControllerDelegate {
  
  func rankingsSearchViewController(_ controller: RankingsSearchViewController, didReceiveRankings rankings: [Ranking]) {
    let presenter = RankingResultsPresenter(rankings: rankings)
    let viewController = RankingResultsViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - RankingResultsViewControllerDelegate

extension RankingsRouter: RankingResultsViewControllerDelegate {
  
  func rankingResultsViewController(_: RankingResultsViewController, didReceiveAthlete athlete: Athlete) {
    let presenter = AthleteProfilePresenter(athlete: athlete)
    let viewController = AthleteProfileViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteProfileViewControllerDelegate

extension RankingsRouter: AthleteProfileViewControllerDelegate {
  
}
