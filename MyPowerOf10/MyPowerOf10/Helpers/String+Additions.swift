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
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var digitsOnly: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}
