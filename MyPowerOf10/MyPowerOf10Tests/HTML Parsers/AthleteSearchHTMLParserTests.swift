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

final class AthleteSearchHTMLParserTests: XCTestCase {
    
    func test_searchMultipleAthletes_correctCount() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListMultiAthletes", fileType: "html")
        do {
            let parser = try AthleteSearchHTMLParser(htmlData: data)
            let athletes = parser.athletesFromSearchResults()
            XCTAssertEqual(athletes.count, 4)
        } catch {
            XCTFail(#function)
        }
    }
    
    func test_searchOneAthlete_correctCount() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListOneAthlete", fileType: "html")
        do {
            let parser = try AthleteSearchHTMLParser(htmlData: data)
            let athletes = parser.athletesFromSearchResults()
            XCTAssertEqual(athletes.count, 1)
        } catch {
            XCTFail(#function)
        }
    }
    
    func test_searchOneAthlete_parsesCorrectly() {
        let data = FileLoader.dataFrom(filename: "AthleteSearchListOneAthlete", fileType: "html")
        do {
            let parser = try AthleteSearchHTMLParser(htmlData: data)
            let athletes = parser.athletesFromSearchResults()
            guard let firstAthlete = athletes.first else { return }
            
            XCTAssertEqual(firstAthlete.firstName, "Maddy")
            XCTAssertEqual(firstAthlete.surname, "Austin")
            XCTAssertEqual(firstAthlete.gender, .female)
            XCTAssertEqual(firstAthlete.clubs, ["Guildford & Godalming", "Edinburgh Uni Hare & Hounds"])
            XCTAssertEqual(firstAthlete.ageGroup, "SEN")
            XCTAssertEqual(firstAthlete.athleteID, "54096")
        } catch {
            XCTFail(#function)
        }
    }
    
}
