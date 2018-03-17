//
//  Athlete.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

struct Performance: Codable {
  let event: String
  let result: String
}

struct Athlete: Codable {
  let athleteID: String
  let name: String
  let club: String
  let gender: Gender
  let ageGroup: String
  let paralympicClass: String?
  let county: String
  let region: String
  let nation: String
  let coach: String
  let bestPerformances: [Performance]
  var isFavourited: Bool
  
  mutating func didToggleFavouriteState(isFavourited: Bool) {
    self.isFavourited = isFavourited
  }
}
