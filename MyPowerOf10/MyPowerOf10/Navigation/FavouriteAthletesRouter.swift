//
//  FavouriteAthletesRouter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 08/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class FavouriteAthletesRouter: UINavigationController {
  
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
  
  private func style() {
    navigationBar.tintColor = .potRed
    if #available(iOS 11.0, *) {
      navigationBar.prefersLargeTitles = true
      navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
    }
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
  }
  
  private func populateViewControllers() {
    let athletes = dataStore.retrieveAllAthletes()
    var athleteResults: [AthleteResult] = []
    athletes.forEach {
      athleteResults.append($0.searchResult)
    }
    let athleteSearchResultsPresenter = AthleteSearchResultsViewPresenter(athleteResults: athleteResults)
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
