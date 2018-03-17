//
//  UIView+Animations.swift
//  Po10UI
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

public extension UIView {
  
  private static let reallyShortAnimationDuration: TimeInterval = 0.1
  private static let shortAnimationDuration: TimeInterval = 0.23
  
  public static func reallyShortAnimation(delay: TimeInterval = 0,
                                   options: UIViewAnimationOptions = [.beginFromCurrentState],
                                   animations: @escaping () -> Void,
                                   completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: reallyShortAnimationDuration,
                   delay: delay,
                   options: options,
                   animations: animations,
                   completion: completion)
  }
  
  public static func shortAnimation(delay: TimeInterval = 0,
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
