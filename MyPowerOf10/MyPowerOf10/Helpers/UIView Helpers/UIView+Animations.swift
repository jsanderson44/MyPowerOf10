//
//  UIView+Animations.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

extension UIView {
  
  private static let reallyShortAnimationDuration: TimeInterval = 0.1
  private static let shortAnimationDuration: TimeInterval = 0.23
  
  static func reallyShortAnimation(delay: TimeInterval = 0,
                                   options: UIViewAnimationOptions = [.beginFromCurrentState],
                                   animations: @escaping () -> Void,
                                   completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: reallyShortAnimationDuration,
                   delay: delay,
                   options: options,
                   animations: animations,
                   completion: completion)
  }
  
  static func shortAnimation(delay: TimeInterval = 0,
                                   options: UIViewAnimationOptions = [.beginFromCurrentState],
                                   animations: @escaping () -> Void,
                                   completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: shortAnimationDuration,
                   delay: delay,
                   options: options,
                   animations: animations,
                   completion: completion)
  }
  
}
