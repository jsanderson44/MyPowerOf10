//
//  AthleteResult.swift
//  Po10Model
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import FoundationExtension

public enum Gender: String, Codable {
  case male = "Male"
  case female = "Female"
  case unknown = "Unknown"
  
  public var searchValue: String {
    switch self {
    case .female:
      return "W"
    default:
      return "M"
    }
  }
}

public extension Gender {
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

//TODO Rename?
public struct AthleteResult: Codable {
  
  public let firstName: String
  public let surname: String
  public let ageGroup: String
  public let gender: Gender
  public let clubs: [String]
  public let athleteID: String?
  
}

public extension AthleteResult {
  init(components: [String]) {
    firstName = components[safe: 2].cleaned.removeTags.removeAmpersand()
    surname = components[safe: 3].cleaned.removeTags.removeAmpersand()
    ageGroup = components[safe: 4].cleaned.removeTags.removeAmpersand()
    gender = Gender(parsedValue: components[safe: 7].cleaned.removeTags.removeAmpersand())
    clubs = components[safe: 8].cleaned.removeTags.removeAmpersand().components(separatedBy: "/")
    athleteID = components.last?.digitsOnly
  }
}

public extension AthleteResult {
  init(athlete: Athlete) {
    firstName = athlete.name
    surname = ""
    ageGroup = athlete.ageGroup
    gender = athlete.gender
    clubs = [athlete.club]
    athleteID = athlete.athleteID
  }
}
