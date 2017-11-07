//
//  String+Additions.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

extension String {
    
    var cleaned: String {
        let stringToTrim = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let startTrimIndex = stringToTrim.index(stringToTrim.startIndex, offsetBy: 4)
        let endTrimIndex = stringToTrim.index(stringToTrim.endIndex, offsetBy: -6)
        return String(stringToTrim[startTrimIndex...endTrimIndex])
    }
    
    var digitsOnly: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}
