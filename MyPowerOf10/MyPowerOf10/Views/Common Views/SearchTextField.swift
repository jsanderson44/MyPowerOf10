//
//  SearchTextField.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class SearchTextField: UITextField {
  
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
  }
  
  private func styleText() {
    font = .systemFont(ofSize: 18)
    textColor = .darkGray // TODO Custom colors
//    tintColor = .darkGray // TODO Custom colors
  }
  
  private func styleBorder() {
    borderStyle = .none
    layer.backgroundColor = UIColor.white.cgColor
    layer.masksToBounds = false
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 0.0
  }
  
  private func styleKeyboard() {
//    autocorrectionType = .no
  }
  
  private func stylePlaceholderText(placeholder: String) {
    let attributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
    let placeholderString = NSAttributedString(string: placeholder, attributes: attributes)
    attributedPlaceholder = placeholderString
  }
  
  // MARK: - Override functions
  @discardableResult
  public override func becomeFirstResponder() -> Bool {
//    layer.borderColor = UIColor.blue.cgColor // TODO custom color
    return super.becomeFirstResponder()
  }
  
  @discardableResult
  public override func resignFirstResponder() -> Bool {
//    layer.borderColor = UIColor.darkGray.cgColor // TODO custom color
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
