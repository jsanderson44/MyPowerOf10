//
//  FavouriteAthletesRouter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 08/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class FavouriteAthletesRouter: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    populateViewControllers()
  }
  
  private func populateViewControllers() {
    let athleteSearchResultsPresenter = AthleteSearchResultsViewPresenter(athleteResults: [], context: .favorites)
    let athleteSearchResultsViewController = AthleteSearchResultsViewController(delegate: self, presenter: athleteSearchResultsPresenter, title: "Favourites")
    viewControllers = [athleteSearchResultsViewController]
  }
  
}

// MARK: - AthleteSearchResultsViewControllerDelegate

extension FavouriteAthletesRouter: AthleteSearchResultsViewControllerDelegate {
  
  func athleteSearchResultsViewController(_ controller: AthleteSearchResultsViewController, didReceiveAthlete athlete: Athlete) {
    let presenter = AthleteProfilePresenter(athlete: athlete)
    let viewController = AthleteProfileViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteProfileViewControllerDelegate

extension FavouriteAthletesRouter: AthleteProfileViewControllerDelegate {
  
}
