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
  
  func athleteProfile() throws -> AthleteProfile {
    guard let name: String = document.css(".athleteprofilesubheader h2").first?.text?.cleaned else { throw AthleteProfileParsingError.couldNotParseAthlete }
    return AthleteProfile(name: name, club: "", ageGroup: "", coach: "")
  }
  
}
