//
//  AthleteProfile.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

struct Performance {
  let event: String
  let result: String
}

struct AthleteProfile {
  let name: String
  let club: String
  let gender: Gender
  let ageGroup: String
  let county: String
  let region: String
  let nation: String
  let coach: String
  let bestPerformances: [Performance]
}