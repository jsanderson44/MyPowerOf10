//
//  FileLoader.swift
//  MyPowerOf10Tests
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

final class FileLoader {
    
    public static func dataFrom(filename: String, fileType: String) -> Data {
        let bundle = Bundle(for: type(of: self.init()))
        guard let path = bundle.path(forResource: filename, ofType: fileType) else {
            fatalError("file not found: \(filename)")
        }
        guard let data = NSData(contentsOfFile: path) as Data? else {
            fatalError("not data found")
        }
        return data
    }
    
}
