//
//  MyPoTRouter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class MyPoTRouter: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    populateViewControllers()
  }
  
  private func style() {
//    navigationBar.setBackgroundImage(UIImage(), for: .default)
//    navigationBar.shadowImage = UIImage()
//    navigationBar.isTranslucent = true
//    navigationBar.backgroundColor = .white
    navigationBar.tintColor = .potRed
    if #available(iOS 11.0, *) {
      navigationBar.prefersLargeTitles = true
      navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
    }
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
  }
  
  private func populateViewControllers() {
    let athleteSearchPresenter = AthleteSearchViewPresenter()
    let athleteSearchViewController = AthleteSearchViewController(delegate: self, presenter: athleteSearchPresenter)
    viewControllers = [athleteSearchViewController]
  }
  
}

// MARK: - AthleteSearchViewControllerDelegate

extension MyPoTRouter: AthleteSearchViewControllerDelegate {
  
  func athleteSearchViewController(_ controller: AthleteSearchViewController, didReceiveAthleteSearchResults athleteResults: [AthleteResult]) {
    let presenter = AthleteSearchResultsViewPresenter(athleteResults: athleteResults)
    let viewController = AthleteSearchResultsViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteSearchResultsViewControllerDelegate

extension MyPoTRouter: AthleteSearchResultsViewControllerDelegate {
  
  func athleteSearchResultsViewController(_ controller: AthleteSearchResultsViewController, didReceiveAthleteProfile profile: AthleteProfile) {
    let presenter = AthleteProfilePresenter(athleteProfile: profile)
    let viewController = AthleteProfileViewController(delegate: self, presenter: presenter)
    pushViewController(viewController, animated: true)
  }
}

// MARK: - AthleteProfileViewControllerDelegate

extension MyPoTRouter: AthleteProfileViewControllerDelegate {
  
}
