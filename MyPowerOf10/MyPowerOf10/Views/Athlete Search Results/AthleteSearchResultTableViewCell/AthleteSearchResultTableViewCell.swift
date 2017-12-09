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
  @IBOutlet private var athleteGenderImageView: UIImageView!
  @IBOutlet private var loadingView: UIActivityIndicatorView!
  @IBOutlet private var topConstraint: NSLayoutConstraint!
  
  // MARK: View lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: Private functions
  
  private func setup() {
    containerView.backgroundColor = .white
    containerView.layer.cornerRadius = AppTheme.cornerRadius
    containerView.layer.borderColor = UIColor.potRed.cgColor
    containerView.layer.borderWidth = AppTheme.mediumBorderWidth
    containerView.applyShadow()
    athleteGenderImageView.tintColor = .potDarkGray
    [athleteNameLabel, athleteClubLabel, athleteAgeGroupLabel].forEach {
      $0?.textColor = .potDarkGray
    }
  }
  
  // MARK: Public functions
  
  func update(with athlete: AthleteResult, isFirstCell: Bool) {
    topConstraint.constant = isFirstCell ? 24 : 4
    athleteNameLabel.text = athlete.firstName + " " + athlete.surname
    athleteClubLabel.text = athlete.clubs.joined(separator: "\n")
    athleteAgeGroupLabel.text = athlete.ageGroup
    
    let genderImageName = athlete.gender == .male ? "male" : "female"
    let genderImage = UIImage(named: genderImageName)
    athleteGenderImageView.image = genderImage
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
