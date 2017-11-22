//
//  GradientView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 22/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class GradientView: UIView {
  
  private var topColor: UIColor? {
    didSet {
      setNeedsDisplay()
    }
  }
  
  private var bottomColor: UIColor? {
    didSet {
      setNeedsDisplay()
    }
  }
  
  func updateWith(topColor: UIColor, bottomColor: UIColor) {
    self.topColor = topColor
    self.bottomColor = bottomColor
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let firstColor = topColor, let secondColor = bottomColor else {
      return
    }
    
    let ctx = UIGraphicsGetCurrentContext()
    let colours = [firstColor.cgColor, secondColor.cgColor] as CFArray
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil) else { return }
    
    let topPoint = CGPoint(x: bounds.size.width, y: bounds.origin.y)
    let bottomPoint = CGPoint(x: 0, y: bounds.size.height)
    
    ctx?.drawLinearGradient(gradient, start: topPoint, end: bottomPoint, options: [CGGradientDrawingOptions.drawsBeforeStartLocation, CGGradientDrawingOptions.drawsAfterEndLocation])
    
  }
  
}
