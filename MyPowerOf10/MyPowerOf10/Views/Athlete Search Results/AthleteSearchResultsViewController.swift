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
  private var athleteResults: [AthleteResult] = []
  
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
    title = "Search Results"
    removeBackButtonTitle()
    setupTableView()
    presenter.requestResults()
  }
  
  // MARK: - Private functions
  
  private func setupTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    registerCells()
  }
  
  private func registerCells() {
    tableView.register(UINib(nibName: "AthleteSearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: AthleteSearchResultTableViewCell.reuseID)
  }
  
}

// MARK: - AthleteSearchViewPresenterDelegate

extension AthleteSearchResultsViewController: AthleteSearchResultsViewPresenterDelegate {
  
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool) {
    guard let cell = tableView.cellForRow(at: indexPath) as? AthleteSearchResultTableViewCell else { return }
    if isLoading {
      cell.startLoading()
      tableView.isUserInteractionEnabled = false
    } else {
      cell.stopLoading()
      tableView.isUserInteractionEnabled = true
    }
  }
  
  func updateWithResults(results: [AthleteResult]) {
    athleteResults = results
  }
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension AthleteSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return athleteResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AthleteSearchResultTableViewCell.reuseID) as? AthleteSearchResultTableViewCell else {
      fatalError("Could not dequeue cell")
    }
    let athlete = athleteResults[indexPath.row]
    cell.update(with: athlete)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectCell(at: indexPath)
  }
}
