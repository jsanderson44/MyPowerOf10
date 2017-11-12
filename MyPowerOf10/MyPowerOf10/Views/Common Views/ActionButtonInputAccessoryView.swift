//
//  ActionButtonInputAccessoryView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol ActionButtonInputAccessoryViewDelegate: class {
  func actionButtonInputAccessoryDidTapActionButton(_ actionButtonInputAccessoryView: ActionButtonInputAccessoryView)
}

final class ActionButtonInputAccessoryView: UIInputView {
  
  // MARK: - Public properties
  public var isLoading: Bool = false {
    didSet {
      actionButton.isLoading = isLoading
    }
  }
  
  // MARK: - Private properties
  
  private weak var delegate: ActionButtonInputAccessoryViewDelegate?
  
  @IBOutlet private var actionButton: RoundedCornerActionButton!
  
  // MARK: - Override functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    isLoading = false
  }

  // MARK: - Actions
  
  @IBAction private func didTapActionButton() {
    delegate?.actionButtonInputAccessoryDidTapActionButton(self)
  }
  
}

extension ActionButtonInputAccessoryView {
  
  func update(actionButtonTitle: String, delegate: ActionButtonInputAccessoryViewDelegate) {
    self.delegate = delegate
    actionButton.setTitle(actionButtonTitle, for: .normal)
  }
  
  func updateStateOfActionButton(isEnabled: Bool) {
    actionButton.isEnabled = isEnabled
  }
  
}
