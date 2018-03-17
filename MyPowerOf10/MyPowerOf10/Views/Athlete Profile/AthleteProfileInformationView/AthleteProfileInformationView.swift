//
//  AthleteProfileInformationView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model

final class AthleteProfileInformationView: UIView {
  
  // MARK: Outlets
  
  @IBOutlet private var clubTitleLabel: UILabel!
  @IBOutlet private var clubLabel: UILabel!
  @IBOutlet private var genderTitleLabel: UILabel!
  @IBOutlet private var genderLabel: UILabel!
  @IBOutlet private var ageGroupTitleLabel: UILabel!
  @IBOutlet private var ageGroupLabel: UILabel!
  @IBOutlet private var classTitleLabel: UILabel!
  @IBOutlet private var classLabel: UILabel!
  @IBOutlet private var coachTitleLabel: UILabel!
  @IBOutlet private var coachLabel: UILabel!
  @IBOutlet private var countyTitleLabel: UILabel!
  @IBOutlet private var countyLabel: UILabel!
  @IBOutlet private var regionTitleLabel: UILabel!
  @IBOutlet private var regionLabel: UILabel!
  @IBOutlet private var nationTitleLabel: UILabel!
  @IBOutlet private var nationLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  // MARK: Private
  
  private func setup() {
    
  }
  
}

extension AthleteProfileInformationView {
  
  func update(with profile: Athlete) {
    clubLabel.text = profile.club.replacingOccurrences(of: "/", with: "\n")
    coachLabel.text = profile.coach
    genderLabel.text = profile.gender.rawValue
    ageGroupLabel.text = profile.ageGroup
    countyLabel.text = profile.county
    regionLabel.text = profile.region
    nationLabel.text = profile.nation
    guard let paralympicClass = profile.paralympicClass else {
      classLabel.isHidden = true
      classTitleLabel.isHidden = true
      return
    }
    classLabel.text = paralympicClass
  }
}
