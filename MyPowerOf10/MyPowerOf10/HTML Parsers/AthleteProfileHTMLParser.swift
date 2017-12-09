//
//  AthleteProfileHTMLParser.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

enum AthleteProfileParsingError: Error {
  case couldNotParseAthlete
}

struct AthleteProfileHTMLParser {
  
  let document: HTMLDocument
  
  init(htmlData: Data) throws {
    let document = try HTML(html: htmlData, encoding: .utf8)
    self.document = document
  }
  
  //TODO refactor
  func athleteProfile() throws -> AthleteProfile {
    guard let name: String = document.css(".athleteprofilesubheader h2").first?.text?.cleaned else { throw AthleteProfileParsingError.couldNotParseAthlete }
    
    let infoComponents: [String] = document.css("#cphBody_pnlAthleteDetails td").flatMap { (details) in
      guard let component = details.text else { return nil }
      return component
    }
    
    let genderString = infoComponents[safe: 5]
    let gender: Gender = Gender(rawValue: genderString) ?? .unknown
    let club = infoComponents[safe: 3]
    let ageGroup = infoComponents[safe: 7]
    let county = infoComponents[safe: 9]
    let region = infoComponents[safe: 11]
    let nation = infoComponents[safe: 13]
    let coach = infoComponents[safe: 16]
    
    var count = 0
    let bestPerformances: [Performance] = document.css("#cphBody_divBestPerformances .bestperformancesheader").flatMap { (eventElement) in
      guard let result = document.css("td[style=\"background-color:LightPink;\"]")[safe: count]?.text,
        let event = eventElement.css("b").first?.text,
        event != "Event" else { return nil }
      count += 1
      return Performance(event: event, result: result)
    }
    
    return AthleteProfile(name: name, club: club, gender: gender, ageGroup: ageGroup, county: county, region: region, nation: nation, coach: coach, bestPerformances: bestPerformances)
  }
  
}
