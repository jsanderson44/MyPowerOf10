//
//  Athlete.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 07/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

struct Athlete: Codable {
  let searchResult: AthleteResult
  let profile: AthleteProfile
  var isFavourited: Bool
  
  mutating func didToggleFavouriteState(isFavourited: Bool) {
    self.isFavourited = isFavourited
  }
}
