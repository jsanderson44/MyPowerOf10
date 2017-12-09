//
//  Array+SafeSubscript.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

extension Array {
  
  /// Safely attempts to retrieve an element at the provided index.
  ///
  /// - Parameter index: The index of the element to try and retrieve.
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
  
}

extension Array where Element == String {
  
  /// Safely attempts to retrieve a string at the provided index.
  /// Returns an empty string if nil is found
  ///
  /// - Parameter index: The index of the element to try and retrieve.
  subscript(safe index: Int) -> String {
    return indices ~= index ? self[index] : ""
  }
  
}
