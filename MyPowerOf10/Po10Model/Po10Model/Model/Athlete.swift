//
//  Athlete.swift
//  Po10Model
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

public struct Performance: Codable {
  public let event: String
  public let result: String
}

public struct Athlete: Codable {
  public let athleteID: String
  public let name: String
  public let club: String
  public let gender: Gender
  public let ageGroup: String
  public let paralympicClass: String?
  public let county: String
  public let region: String
  public let nation: String
  public let coach: String
  public let bestPerformances: [Performance]
  public var isFavourited: Bool
  
  public mutating func didToggleFavouriteState(isFavourited: Bool) {
    self.isFavourited = isFavourited
  }
}
