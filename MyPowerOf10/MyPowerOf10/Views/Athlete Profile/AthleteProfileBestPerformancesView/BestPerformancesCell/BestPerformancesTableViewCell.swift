//
//  BestPerformancesTableViewCell.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class BestPerformancesTableViewCell: UITableViewCell {
  
  static let reuseID = "BestPerformancesTableViewCell"

  // MARK: Outlets
  
  @IBOutlet private var seperatorLine: UIView!
  @IBOutlet private var eventLabel: UILabel!
  @IBOutlet private var resultLabel: UILabel!
  
  // MARK: View lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: Private functions
  
  private func setup() {
    seperatorLine.backgroundColor = .potRed
  }
}

extension BestPerformancesTableViewCell {
  
  func update(with performance: Performance) {
    eventLabel.text = performance.event
    resultLabel.text = performance.result
  }
}
