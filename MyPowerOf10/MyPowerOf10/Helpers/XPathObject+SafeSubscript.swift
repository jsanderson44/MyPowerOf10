//
//  XPathObject+SafeSubscript.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Kanna

extension XPathObject {
  
  /// Safely attempts to retrieve an element at the provided index.
  ///
  /// - Parameter index: The index of the element to try and retrieve.
  subscript(safe index: Int) -> XMLElement? {
    return count-1 >= index ? self[index] : nil
  }
}
