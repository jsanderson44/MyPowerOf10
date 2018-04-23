//
//  AthleteProfileHTMLParser.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import FoundationExtension
import Kanna

enum AthleteProfileParsingError: Error {
  case couldNotParseAthlete
}

struct AthleteProfileHTMLParser {
  
  let document: HTMLDocument
  private let athleteID: String
  
  init(htmlData: Data, athleteID: String) throws {
    let document = try HTML(html: htmlData, encoding: .utf8)
    self.document = document
    self.athleteID = athleteID
  }
  
  //TODO refactor
  func athleteProfile() throws -> Athlete {
    guard let name: String = document.css(".athleteprofilesubheader h2").first?.text?.cleaned else { throw AthleteProfileParsingError.couldNotParseAthlete }
    
    let infoComponents: [String] = document.css("#cphBody_pnlAthleteDetails td").compactMap { (details) in
      guard let component = details.text else { return nil }
      return component
    }
    
    let genderString = infoComponents[safe: 5]
    let gender: Gender = Gender(rawValue: genderString) ?? .unknown
    let club = infoComponents[safe: 3]
    let ageGroup = infoComponents[safe: 7]
    
    var paralympicClass: String? = nil
    var countyIndex = 9
    if infoComponents[8] == "Class:" {
      paralympicClass = infoComponents[safe: 9]
      countyIndex = 11
    }
    
    let county = infoComponents[safe: countyIndex]
    let region = infoComponents[safe: countyIndex+2]
    let nation = infoComponents[safe: countyIndex+4]
    let coach = infoComponents[safe: countyIndex+7]
    
    var count = 0
    let bestPerformances: [Performance] = document.css("#cphBody_divBestPerformances .bestperformancesheader").compactMap { (eventElement) in
      guard let result = document.css("td[style=\"background-color:LightPink;\"]")[safe: count]?.text,
        let event = eventElement.css("b").first?.text,
        event != "Event" else { return nil }
      count += 1
      return Performance(event: event, result: result)
    }
    
    return Athlete(athleteID: athleteID, name: name, club: club, gender: gender, ageGroup: ageGroup, paralympicClass: paralympicClass, county: county, region: region, nation: nation, coach: coach, bestPerformances: bestPerformances, isFavourited: false)
  }
  
}
