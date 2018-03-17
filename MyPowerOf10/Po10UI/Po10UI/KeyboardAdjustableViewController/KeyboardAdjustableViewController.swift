//
//  KeyboardAdjustableViewController.swift
//  Po10UI
//
//  Created by John Sanderson on 12/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

public protocol KeyboardAdjustableViewController {}

public extension KeyboardAdjustableViewController where Self : UIViewController {
  
  public func observeKeyboardHeightChange(with selector: Selector) {
    NotificationCenter.default.addObserver(self, selector: selector, name: .UIKeyboardWillChangeFrame, object: nil)
  }
  
  public func unregisterKeyboardObservers() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
  }
  
  public func keyboardHeight(for notification: Notification) -> CGFloat {
    guard let window = self.view.window, let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, let _ = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
      return 0
    }
    
    let endFrame = value.cgRectValue
    let endYPosition = window.frame.height - endFrame.origin.y
    
    return endYPosition
  }
  
}
