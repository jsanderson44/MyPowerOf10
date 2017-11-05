//
//  HTMLParserTests.swift
//  MyPowerOf10Tests
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import XCTest
@testable import Kanna
@testable import MyPowerOf10

final class HTMLParserTests: XCTestCase {
    
    func testGetAthlete() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListMultiAthletes", fileType: "html")
        do {
            let parser = try HTMLParser(htmlData: data)
            let athletes = try parser.athletes()
            print(athletes)
        } catch {
            XCTFail(#function)
        }
    }
    
}
