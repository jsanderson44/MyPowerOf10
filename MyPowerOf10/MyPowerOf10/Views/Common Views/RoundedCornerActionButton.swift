//
//  RoundedCornerActionButton.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

class RoundedCornerActionButton: UIButton {
  
  // MARK: - Override properties
  public override var isEnabled: Bool {
    didSet {
      backgroundColor = isEnabled ? .potRed : .potLightGray
    }
  }
  
  // MARK: - Initialisers
  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    style()
  }
  
  // MARK: - Private functions
  private func style() {
    layer.cornerRadius = 8.0
    backgroundColor = .potRed
    styleTitleLabel()
  }
  
  private func styleTitleLabel() {
    titleLabel?.font = .systemFont(ofSize: 24)
    setTitleColor(.white, for: .normal)
    setTitleColor(.white, for: .highlighted)
  }
}
