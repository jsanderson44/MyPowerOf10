//
//  UIView+NibLoading.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

/// Protocol to be extended with implementations
public protocol UIViewLoading {}

/// Extend UIView to declare that it includes nib loading functionality
extension UIView: UIViewLoading {}

/// Protocol implementation
public extension UIViewLoading where Self : UIView {
  
  /**
   Creates a new instance of the class on which this method is invoked,
   instantiated from a nib of the given name. If no nib name is given
   then a nib with the name of the class is used.
   
   - parameter nibNameOrNil: The name of the nib to instantiate from, or
   nil to indicate the nib with the name of the class should be used.
   
   - returns: A new instance of the class, loaded from a nib.
   */
  public static func loadFromNib(_ nibNameOrNil: String? = nil) -> Self {
    let nibName = nibNameOrNil ?? "\(classForCoder())"
    let nib = UINib(nibName: nibName, bundle: Bundle(for: self))
    return nib.instantiate(withOwner: self, options: nil).first as! Self
  }
}
