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
  
  // MARK: - Private properties
  
  private weak var delegate: ActionButtonInputAccessoryViewDelegate?
  
  @IBOutlet private var actionButton: UIButton!
  
  // MARK: - Override functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Actions
  
  @IBAction private func didTapActionButton() {
    delegate?.actionButtonInputAccessoryDidTapActionButton(self)
  }
  
}

extension ActionButtonInputAccessoryView {
  
  public func update(actionButtonTitle: String, delegate: ActionButtonInputAccessoryViewDelegate) {
    self.delegate = delegate
    actionButton.setTitle(actionButtonTitle, for: .normal)
  }
  
}
