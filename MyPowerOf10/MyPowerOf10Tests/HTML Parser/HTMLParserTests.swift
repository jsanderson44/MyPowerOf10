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
    
    func test_searchMultipleAthletes() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListMultiAthletes", fileType: "html")
        do {
            let parser = try HTMLParser(htmlData: data)
            let athletes = parser.athletesFromSearchResults()
            XCTAssertEqual(athletes.count, 4)
        } catch {
            XCTFail(#function)
        }
    }
    
    func test_searchOneAthlete() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListOneAthlete", fileType: "html")
        do {
            let parser = try HTMLParser(htmlData: data)
            let athletes = parser.athletesFromSearchResults()
            XCTAssertEqual(athletes.count, 1)
        } catch {
            XCTFail(#function)
        }
    }
    
}
