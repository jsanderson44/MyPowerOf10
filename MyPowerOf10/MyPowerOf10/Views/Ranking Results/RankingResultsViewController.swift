//
//  RankingResultsViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 01/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import UIKit

protocol RankingResultsViewControllerDelegate: class {
  func rankingResultsViewController(_: RankingResultsViewController, didReceiveAthlete athlete: Athlete)
}

/// Presents a list of rankings to the user
final class RankingResultsViewController: UIViewController {
	
	// MARK: Internal
	
	weak var delegate: RankingResultsViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: RankingResultsPresenter
  private var rankings: [Ranking] = []
  
  // MARK: Outlets
  
  @IBOutlet private var tableView: UITableView!
	
	// MARK: - Initialiers -
	
	init(delegate: RankingResultsViewControllerDelegate, presenter: RankingResultsPresenter) {
		self.presenter = presenter
		self.delegate = delegate
		super.init(nibName: String(describing: RankingResultsViewController.self), bundle: Bundle(for: RankingResultsViewController.self))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
    title = "Top 50"
    presenter.view = self
    setup()
    removeBackButtonTitle()
    addLogoItemToNavigationBar()
    presenter.requestRankings()
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if #available(iOS 11.0, *) {
      navigationController?.navigationBar.prefersLargeTitles = false
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if #available(iOS 11.0, *) {
      navigationController?.navigationBar.prefersLargeTitles = true
    }
  }
  
  // MARK: Private functions
  
  private func setup() {
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
    tableView.rowHeight = 48
    tableView.register(UINib(nibName: "RankingResultTableViewCell", bundle: nil), forCellReuseIdentifier: RankingResultTableViewCell.reuseID)
  }
	
}

// MARK: RankingResultsPresenterView

extension RankingResultsViewController: RankingResultsPresenterView {
	
  func presenterDidReceiveRankings(rankings: [Ranking], requestDisplayString: String) {
    self.rankings = rankings
    configureMultilineNavigationTitle(title: "Top 50", subtitle: requestDisplayString)
    tableView.reloadData()
  }
  
  func presenterDidRecieveAthlete(athlete: Athlete) {
    delegate?.rankingResultsViewController(self, didReceiveAthlete: athlete)
  }
  
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RankingResultTableViewCell else { return }
    tableView.isUserInteractionEnabled = !isLoading
    if isLoading {
      cell.startLoading()
    } else {
      cell.stopLoading()
    }
  }
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension RankingResultsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rankings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingResultTableViewCell.reuseID) as? RankingResultTableViewCell else {
      fatalError("Could not dequeue cell")
    }
    let ranking = rankings[indexPath.row]
    cell.update(with: ranking, position: indexPath.row + 1)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectCell(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
}
