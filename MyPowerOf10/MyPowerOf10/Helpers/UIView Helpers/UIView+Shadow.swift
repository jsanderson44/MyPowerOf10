//
//  UIView+Shadow.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 22/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

/// Represents a shadow that can be applied to a view.
public struct Shadow {
  
  let color: UIColor
  let offset: CGSize
  let radius: CGFloat
  let opacity: Float
  
  public init(color: UIColor = .black,
              offset: CGSize = CGSize(width: 0, height: 8),
              radius: CGFloat = 16,
              opacity: Float = 0.06) {
    self.color = color
    self.offset = offset
    self.radius = radius
    self.opacity = opacity
  }
  
}

public extension UIView {
  
  /// Applies a shadow to the view.
  ///
  /// - Parameter shadow: The shadow to apply.
  public func applyShadow(_ shadow: Shadow = Shadow()) {
    layer.shadowColor = shadow.color.cgColor
    layer.shadowOffset = shadow.offset
    layer.shadowRadius = shadow.radius
    layer.shadowOpacity = shadow.opacity
  }
  
}
