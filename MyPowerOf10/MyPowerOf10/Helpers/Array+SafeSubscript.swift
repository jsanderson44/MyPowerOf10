//
//  Array+SafeSubscript.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

public extension Array {
  
  /// Safely attempts to retrieve an element at the provided index.
  ///
  /// - Parameter index: The index of the element to try and retrieve.
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
  
}
