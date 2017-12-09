//
//  AthleteResult.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

enum Gender: String, Codable {
  case male = "Male"
  case female = "Female"
  case unknown = "Unknown"
}

extension Gender {
  init(parsedValue: String?) {
    guard let value = parsedValue else {
      self = .unknown
      return
    }
    switch value {
    case "M": self = .male
    case "W": self = .female
    default: self = .unknown
    }
  }
}

struct AthleteResult: Codable {
  
  let firstName: String
  let surname: String
  let ageGroup: String
  let gender: Gender
  let clubs: [String]
  let athleteID: String?
  
}

extension AthleteResult {
  init(components: [String]) {
    firstName = components[safe: 2].cleaned.removeTags.removeAmpersand()
    surname = components[safe: 3].cleaned.removeTags.removeAmpersand()
    ageGroup = components[safe: 4].cleaned.removeTags.removeAmpersand()
    gender = Gender(parsedValue: components[safe: 7].cleaned.removeTags.removeAmpersand())
    clubs = components[safe: 8].cleaned.removeTags.removeAmpersand().components(separatedBy: "/")
    athleteID = components.last?.digitsOnly
  }
}
