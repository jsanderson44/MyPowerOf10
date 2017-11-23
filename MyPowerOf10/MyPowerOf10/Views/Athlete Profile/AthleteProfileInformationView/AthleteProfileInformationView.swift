//
//  AthleteProfileInformationView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class AthleteProfileInformationView: UIView {
  
  // MARK: Outlets
  
  @IBOutlet private var clubLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  // MARK: Private
  
  private func setup() {
    
  }
  
}

extension AthleteProfileInformationView {
  
  func update(with profile: AthleteProfile) {
    clubLabel.text = profile.club
  }
}
