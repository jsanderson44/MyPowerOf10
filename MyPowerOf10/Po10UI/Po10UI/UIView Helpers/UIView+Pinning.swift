//
//  UIView+Pinning.swift
//  Po10UI
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

public extension UIView {
  
  /// Pins a view to the specified view using optional edge insets.
  ///
  /// - Parameters:
  ///   - view: The view to pin to.
  ///   - edgeInsets: The edge insets to apply.
  public func pin(toView view: UIView, withEdgeInsets edgeInsets: UIEdgeInsets = .zero) {
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left),
      self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: edgeInsets.right),
      self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top),
      self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edgeInsets.bottom)
      ])
  }
  
  /// Centers a view to the specified view.
  ///
  /// - Parameter view: The view to center to.
  public func center(inView view: UIView) {
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
  }
  
}
