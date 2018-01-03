//
//  RankingResultTableViewCell.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class RankingResultTableViewCell: UITableViewCell {
  
  static let reuseID = "RankingResultTableViewCell"

  // MARK: Outlets
  
  @IBOutlet private var containerView: UIView!
  @IBOutlet private var loadingView: UIActivityIndicatorView!
  @IBOutlet private var seperatorLine: UIView!
  @IBOutlet private var positionLabel: UILabel!
  @IBOutlet private var athleteNameLabel: UILabel!
  @IBOutlet private var performanceLabel: UILabel!
  
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

extension RankingResultTableViewCell {
  
  func update(with ranking: Ranking, position: Int) {
    positionLabel.text = "\(position)"
    athleteNameLabel.text = ranking.athleteName
    performanceLabel.text = ranking.performance
  }
  
  func startLoading() {
    loadingView.startAnimating()
    UIView.reallyShortAnimation(animations: {
      self.containerView.alpha = 0.3
      self.containerView.layer.borderColor = UIColor.potDarkGray.cgColor
    })
  }
  
  func stopLoading() {
    loadingView.stopAnimating()
    UIView.reallyShortAnimation(animations: {
      self.containerView.alpha = 1.0
      self.containerView.layer.borderColor = UIColor.potRed.cgColor
    })
  }
}
