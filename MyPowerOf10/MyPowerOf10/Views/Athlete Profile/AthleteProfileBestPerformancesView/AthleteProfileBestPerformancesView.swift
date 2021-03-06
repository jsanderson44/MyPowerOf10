//
//  AthleteProfileBestPerformancesView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model

final class AthleteProfileBestPerformancesView: UIView {

  // MARK: Outlets
  
  @IBOutlet private var tableView: UITableView!
  
  // MARK: Private
  
  private var performances: [Performance] = []
  
  // MARK: View lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: Private functions
  
  private func setup() {
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24))
    tableView.rowHeight = 48
    tableView.register(UINib(nibName: "BestPerformancesTableViewCell", bundle: nil), forCellReuseIdentifier: BestPerformancesTableViewCell.reuseID)
  }
  
}

extension AthleteProfileBestPerformancesView {
  
  func update(with performances: [Performance]) {
    self.performances = performances
    tableView.reloadData()
  }
  
  func contentHeight() -> CGFloat {
    return tableView.contentSize.height
  }
  
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension AthleteProfileBestPerformancesView: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return performances.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BestPerformancesTableViewCell.reuseID) as? BestPerformancesTableViewCell else {
      fatalError("Could not dequeue cell")
    }
    let performance = performances[indexPath.row]
    cell.update(with: performance)
    return cell
  }
  
}
