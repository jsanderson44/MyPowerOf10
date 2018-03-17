//
//  AthleteSearchRouter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model
import Po10UI

final class AthleteSearchRouter: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    populateViewControllers()
  }
  
  private func populateViewControllers() {
    let athleteSearchPresenter = AthleteSearchViewPresenter()
    let athleteSearchViewController = AthleteSearchViewController(delegate: self, presenter: athleteSearchPresenter)
    viewControllers = [athleteSearchViewController]
  }
  
}

// MARK: - AthleteSearchViewControllerDelegate

extension AthleteSearchRouter: AthleteSearchViewControllerDelegate {
  
  func athleteSearchViewController(_ controller: AthleteSearchViewController, didReceiveAthleteSearchResults athleteResults: [AthleteResult]) {
    let presenter = AthleteSearchResultsViewPresenter(athleteResults: athleteResults, context: .searchResults)
    let viewController = AthleteSearchResultsViewController(delegate: self, presenter: presenter, title: "Search Results")
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteSearchResultsViewControllerDelegate

extension AthleteSearchRouter: AthleteSearchResultsViewControllerDelegate {
  
  func athleteSearchResultsViewController(_ controller: AthleteSearchResultsViewController, didReceiveAthlete athlete: Athlete) {
    let presenter = AthleteProfilePresenter(athlete: athlete)
    let viewController = AthleteProfileViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteProfileViewControllerDelegate

extension AthleteSearchRouter: AthleteProfileViewControllerDelegate {
  
}
