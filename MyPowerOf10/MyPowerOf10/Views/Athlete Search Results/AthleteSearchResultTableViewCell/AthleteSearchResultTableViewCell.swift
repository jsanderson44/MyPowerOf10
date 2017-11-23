//
//  AthleteSearchResultTableViewCell.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 22/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class AthleteSearchResultTableViewCell: UITableViewCell {

  static let reuseID = "AthleteSearchResultTableViewCell"
  
  // MARK: Outlets
  
  @IBOutlet private var containerView: UIView!
  @IBOutlet private var athleteNameLabel: UILabel!
  @IBOutlet private var athleteClubLabel: UILabel!
  @IBOutlet private var athleteAgeGroupLabel: UILabel!
  @IBOutlet private var loadingView: UIActivityIndicatorView!
  
  // MARK: View lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: Private functions
  
  private func setup() {
    containerView.backgroundColor = .white
    containerView.layer.cornerRadius = 4.0
    containerView.layer.borderColor = UIColor.potDarkGray.cgColor
    containerView.layer.borderWidth = 2.0
    containerView.applyShadow()
    [athleteNameLabel, athleteClubLabel, athleteAgeGroupLabel].forEach {
      $0?.textColor = .potDarkGray
    }
  }
  
  // MARK: Public functions
  
  func update(with athlete: AthleteResult) {
    athleteNameLabel.text = athlete.firstName + " " + athlete.surname
    athleteClubLabel.text = athlete.clubs.joined(separator: "\n")
    athleteAgeGroupLabel.text = athlete.ageGroup
  }
  
  func startLoading() {
    loadingView.startAnimating()
    UIView.animate(withDuration: 0.1) {
      self.containerView.alpha = 0.3
      self.containerView.layer.borderColor = UIColor.potRed.cgColor
    }
  }
  
  func stopLoading() {
    loadingView.stopAnimating()
    UIView.animate(withDuration: 0.1) {
      self.containerView.alpha = 1.0
      self.containerView.layer.borderColor = UIColor.potDarkGray.cgColor
    }
  }
  
}
