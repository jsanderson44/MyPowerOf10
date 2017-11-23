//
//  AthleteProfileToggleView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol AthleteProfileToggleViewDelegate: class {
  func athleteProfileToggleViewDidTapLeftToggle(_ athleteProfileToggleView: AthleteProfileToggleView)
  func athleteProfileToggleViewDidTapRightToggle(_ athleteProfileToggleView: AthleteProfileToggleView)
}

final class AthleteProfileToggleView: UIView {
  
  // MARK: Outlets

  @IBOutlet private var leftLabel: UILabel!
  @IBOutlet private var rightLabel: UILabel!
  @IBOutlet private var leftSelectionView: UIView!
  @IBOutlet private var rightSelectionView: UIView!
  @IBOutlet private var leftSelectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var rightSelectionViewHeightConstraint: NSLayoutConstraint!
  
  // MARK: Private
  
  private let selectedFont = UIFont.systemFont(ofSize: 22, weight: .medium)
  private let deselectedFont = UIFont.systemFont(ofSize: 22, weight: .regular)
  private let selectedHeight: CGFloat = 4.0
  private let deselectedHeight: CGFloat = 2.0
  private let selectedTintColor = UIColor.potRed
  private let deselectedTintColor = UIColor.potLightGray
  
  // MARK: Internal
  
  weak var delegate: AthleteProfileToggleViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  // MARK: Private
  
  private func setup() {
    setupDefaultState()
    setupGestureRecognisers()
  }
  
  private func setupDefaultState() {
    leftLabel.font = selectedFont
    leftSelectionViewHeightConstraint.constant = selectedHeight
    leftSelectionView.backgroundColor = selectedTintColor
    
    rightLabel.font = deselectedFont
    rightSelectionViewHeightConstraint.constant = deselectedHeight
    rightSelectionView.backgroundColor = deselectedTintColor
  }
  
  private func setupGestureRecognisers() {
    let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLeftButton))
    leftLabel.addGestureRecognizer(leftTapGesture)
    
    let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRightButton))
    rightLabel.addGestureRecognizer(rightTapGesture)
  }
  
  @objc private func didTapLeftButton() {
    leftLabel.font = selectedFont
    leftSelectionViewHeightConstraint.constant = selectedHeight
    leftSelectionView.backgroundColor = selectedTintColor
    
    rightLabel.font = deselectedFont
    rightSelectionViewHeightConstraint.constant = deselectedHeight
    rightSelectionView.backgroundColor = deselectedTintColor
    delegate?.athleteProfileToggleViewDidTapLeftToggle(self)
  }
  
  @objc private func didTapRightButton() {
    rightLabel.font = selectedFont
    rightSelectionViewHeightConstraint.constant = selectedHeight
    rightSelectionView.backgroundColor = selectedTintColor
    
    leftLabel.font = deselectedFont
    leftSelectionViewHeightConstraint.constant = deselectedHeight
    leftSelectionView.backgroundColor = deselectedTintColor
    delegate?.athleteProfileToggleViewDidTapRightToggle(self)
  }
  
}
