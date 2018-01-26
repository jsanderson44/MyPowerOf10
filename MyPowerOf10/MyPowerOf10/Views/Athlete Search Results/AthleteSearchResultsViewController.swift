//
//  AthleteSearchResultsViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol AthleteSearchResultsViewControllerDelegate: class {
  func athleteSearchResultsViewController(_ controller: AthleteSearchResultsViewController, didReceiveAthlete athlete: Athlete)
}

/// Handles the user interface for the Athlete Search results
final class AthleteSearchResultsViewController: UIViewController {
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchResultsViewControllerDelegate?
  
  // MARK: Private
  
  private let presenter: AthleteSearchResultsViewPresenter
  private var athleteResults: [AthleteResult] = []
  
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var noResutsLabel: UILabel!
  @IBOutlet private var errorViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var errorViewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Initialiers -
  
  init(delegate: AthleteSearchResultsViewControllerDelegate, presenter: AthleteSearchResultsViewPresenter, title: String) {
    self.presenter = presenter
    self.delegate = delegate
    super.init(nibName: String(describing: AthleteSearchResultsViewController.self), bundle: .main)
    self.title = title
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.view = self
    noResutsLabel.textColor = .potDarkGray
    removeBackButtonTitle()
    addLogoItemToNavigationBar()
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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

// MARK: - AthleteSearchPresenterView

extension AthleteSearchResultsViewController: AthleteSearchResultsPresenterView {
  
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
  
  func updateErrorState(isVisible: Bool) {
    let constraintConstant: CGFloat = isVisible ? 48 : 0
    errorViewHeightConstraint.constant = constraintConstant
    UIView.shortAnimation(animations: {
      self.view.layoutIfNeeded()
//      self.tableView.reloadData() //TODO Tidy this up
    })
  }
  
  func updateWithResults(results: [AthleteResult]) {
    noResutsLabel.isHidden = true
    tableView.isHidden = false
    athleteResults = results
    tableView.reloadData()
  }
  
  func updateWithNoResultsMessage(message: String) {
    noResutsLabel.isHidden = false
    tableView.isHidden = true
    noResutsLabel.text = message
  }
  
  func didRecieveAthlete(athlete: Athlete) {
    delegate?.athleteSearchResultsViewController(self, didReceiveAthlete: athlete)
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
    let isFirstCell = indexPath.row == 0
    let isErrorPresented = errorViewHeightConstraint.constant == 48 //TODO - pull these into constants
    cell.update(with: athlete, isFirstCell: isFirstCell, isErrorPresented: isErrorPresented)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectCell(at: indexPath)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -64 {
      errorViewTopConstraint.constant = -scrollView.contentOffset.y
    } else {
      errorViewTopConstraint.constant = 64
    }
  }
}
