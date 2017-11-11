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
  private var athleteResults: [AthleteResult]?
  
  @IBOutlet private var tableView: UITableView!
  
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
    athleteResults = results
    tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension AthleteSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let results = athleteResults else { return 0 }
    return results.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let athleteResults = athleteResults else {
      return UITableViewCell()
    }
    let cell = UITableViewCell()
    cell.textLabel?.text = athleteResults[indexPath.row].firstName + " " + athleteResults[indexPath.row].surname + ", " + athleteResults[indexPath.row].clubs.first!
    return cell
  }
  
}
