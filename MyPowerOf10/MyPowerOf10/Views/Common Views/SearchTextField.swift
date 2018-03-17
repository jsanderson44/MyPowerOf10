//
//  SearchTextField.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10UI

/// Rounded action button with optional loading state
final class SearchTextField: UITextField {
  
  private var padding = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
  
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
    styleText()
    styleBorder()
    styleKeyboard()
//    applyShadow()
    backgroundColor = .potBackgroundGray
  }
  
  private func styleText() {
    font = .systemFont(ofSize: 20)
    textColor = .potDarkGray
    tintColor = .potLightGray
  }
  
  private func styleBorder() {
    borderStyle = .none
    layer.borderColor = UIColor.potLightGray.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = AppTheme.cornerRadius
  }
  
  private func styleKeyboard() {
    autocorrectionType = .no
    autocapitalizationType = .words
  }
  
  private func stylePlaceholderText(placeholder: String) {
    let attributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
    let placeholderString = NSAttributedString(string: placeholder, attributes: attributes)
    attributedPlaceholder = placeholderString
  }
  
  // MARK: - Override functions
  override public func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  override public func editingRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  @discardableResult
  public override func becomeFirstResponder() -> Bool {
    layer.borderColor = UIColor.potRed.cgColor
    layer.borderWidth = 2.0
    return super.becomeFirstResponder()
  }
  
  @discardableResult
  public override func resignFirstResponder() -> Bool {
    layer.borderColor = UIColor.potLightGray.cgColor
    layer.borderWidth = 1.0
    return super.resignFirstResponder()
  }
}

extension SearchTextField {
  
  public func update(withPlaceholder placeholder: String, keyboardType: UIKeyboardType = .alphabet, delegate: UITextFieldDelegate? = nil) {
    stylePlaceholderText(placeholder: placeholder)
    style()
    self.keyboardType = keyboardType
    self.delegate = delegate
  }
  
}
