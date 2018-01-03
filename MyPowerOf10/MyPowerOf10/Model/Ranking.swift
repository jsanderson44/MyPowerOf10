//
//  Ranking.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 02/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

struct Ranking {
  let performance: String?
  let personalBest: String?
  let athleteName: String
  let ageGroup: String
  let coach: String
  let club: String
  let venue: String?
  let date: String //TODO Cast to Date
  let athleteID: String
  
  init(components: XPathObject, athleteID: String) {
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
