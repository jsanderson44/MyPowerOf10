//
//  RankingQueryItemsVendor.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 10/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

enum RankingPlistType: String {
  case ageGroups = "AgeGroups"
  case regions = "Regions"
}

struct RankingQueryItem: Decodable {
  let displayName: String
  let searchQuery: String
}

struct RankingQueryItemsVender {
  
  func rankingQueryItems(forPlist plist: RankingPlistType) -> [RankingQueryItem] {
    let decoder = PropertyListDecoder()
    guard let plistURL = Bundle.main.url(forResource: plist.rawValue, withExtension: "plist"),
      let data = try? Data(contentsOf: plistURL),
      let events = try? decoder.decode(Array<RankingQueryItem>.self, from: data) else { return [] }
    return events
  }
  
  func years() -> [RankingQueryItem] {
    let currentYear = Calendar.current.component(.year, from: Date())
    var years: [RankingQueryItem] = []
    for year in 2006...currentYear {
      years.append(RankingQueryItem(displayName: "\(year)", searchQuery: "\(year)"))
    }
    years.reverse()
    years.append(RankingQueryItem(displayName: "All Time", searchQuery: "y"))
    return years
  }
  
  func events(for ageGroup: String, andGender gender: Gender) -> [RankingQueryItem] {
    let eventsDictionaryQuery = ageGroup + gender.searchValue
    let decoder = PropertyListDecoder()
    guard let eventsPlistURL = Bundle.main.url(forResource: "Events", withExtension: "plist"),
      let data = try? Data(contentsOf: eventsPlistURL),
      let eventsDictionary = try? decoder.decode(Dictionary<String, [RankingQueryItem]>.self, from: data),
      let events = eventsDictionary[eventsDictionaryQuery] else { return [] }
    return events
  }
  
}
