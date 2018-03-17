//
//  RankingQueryItemsVendor.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 10/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Po10Model

enum RankingPlistType: String {
  case ageGroups = "AgeGroups"
  case regions = "Regions"
}

struct RankingQueryItemsVender {
  
  func rankingQueryItems(forPlist plist: RankingPlistType) -> [RankingSearchRequest.RankingQueryItem] {
    let decoder = PropertyListDecoder()
    guard let plistURL = Bundle.main.url(forResource: plist.rawValue, withExtension: "plist"),
      let data = try? Data(contentsOf: plistURL),
      let events = try? decoder.decode(Array<RankingSearchRequest.RankingQueryItem>.self, from: data) else { return [] }
    return events
  }
  
  func years() -> [RankingSearchRequest.RankingQueryItem] {
    let currentYear = Calendar.current.component(.year, from: Date())
    var years: [RankingSearchRequest.RankingQueryItem] = []
    for year in 2006...currentYear {
      years.append(RankingSearchRequest.RankingQueryItem(displayName: "\(year)", searchQuery: "\(year)"))
    }
    years.reverse()
    years.append(RankingSearchRequest.RankingQueryItem(displayName: "All Time", searchQuery: "y"))
    return years
  }
  
  func events(forAgeGroup ageGroup: RankingSearchRequest.RankingQueryItem?, andGender gender: Gender) -> [RankingSearchRequest.RankingQueryItem] {
    guard let ageGroupQuery = ageGroup?.displayName else { return [] }
    let eventsDictionaryQuery = ageGroupQuery + gender.searchValue
    let decoder = PropertyListDecoder()
    guard let eventsPlistURL = Bundle.main.url(forResource: "Events", withExtension: "plist"),
      let data = try? Data(contentsOf: eventsPlistURL),
      let eventsDictionary = try? decoder.decode(Dictionary<String, [RankingSearchRequest.RankingQueryItem]>.self, from: data),
      let events = eventsDictionary[eventsDictionaryQuery] else { return [] }
    return events
  }
  
}
