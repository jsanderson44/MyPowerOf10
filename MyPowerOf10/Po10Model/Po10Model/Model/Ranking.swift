//
//  Ranking.swift
//  Po10Model
//
//  Created by John Sanderson on 02/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import FoundationExtension
import Kanna

public struct Ranking {
  public let performance: String?
  public let personalBest: String?
  public let athleteName: String
  public let ageGroup: String
  public let coach: String
  public let club: String
  public let venue: String?
  public let date: String //TODO Cast to Date
  public let athleteID: String
  
  public init(components: XPathObject, athleteID: String) {
    performance = components[safe: 1]?.text
    personalBest = components[safe: 4]?.text
    athleteName = components[safe: 6]?.text ?? ""
    ageGroup = components[safe: 7]?.text == "" ? "Senior" : components[safe: 7]?.text ?? "Senior"
    coach = components[safe: 9]?.text ?? "None"
    club = components[safe: 10]?.text ?? ""
    venue = components[safe: 11]?.text ?? ""
    date = components[safe: 12]?.text ?? ""
    self.athleteID = athleteID
  }
}
