//
//  AthleteSearchResultsViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol AthleteSearchResultsViewControllerDelegate: class {
  // TODO: Add delegate requirements
}

/// Handles the user interface for the Athlete Search results
final class AthleteSearchResultsViewController: UIViewController {
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchResultsViewControllerDelegate?
  
  // MARK: Private
  
  private let presenter: AthleteSearchResultsViewPresenter
  
  // MARK: - Initialiers -
  
  init(delegate: AthleteSearchResultsViewControllerDelegate, presenter: AthleteSearchResultsViewPresenter) {
    self.presenter = presenter
    self.delegate = delegate
    super.init(nibName: String(describing: AthleteSearchResultsViewController.self), bundle: .main)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.delegate = self
    title = "Athlete Search Results"
    presenter.requestResults()
  }
  
}

// MARK: - AthleteSearchViewPresenterDelegate

extension AthleteSearchResultsViewController: AthleteSearchResultsViewPresenterDelegate {
  
  func updateWithResults(results: [AthleteResult]) {
    print(results)
  }
}
