//
//  String+Additions.swift
//  FoundationExtension
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

public extension String {
  
  var cleaned: String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  var removeTags: String {
    let startTrimIndex = self.index(self.startIndex, offsetBy: 4)
    let endTrimIndex = self.index(self.endIndex, offsetBy: -6)
    return String(self[startTrimIndex...endTrimIndex])
  }
  
  var digitsOnly: String {
    return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
  }
  
  func removeAmpersand() -> String {
    return self.replacingOccurrences(of: "&amp;", with: "&")
  }
  
}
