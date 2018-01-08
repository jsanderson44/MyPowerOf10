//
//  RankingsSearchHTMLParser.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 25/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

struct RankingsSearchHTMLParser {
  
  let document: HTMLDocument
  let isDisabilitySearch: Bool
  
  init(htmlData: Data, isDisabilitySearch: Bool) throws {
    let document = try HTML(html: htmlData, encoding: .utf8)
    self.document = document
    self.isDisabilitySearch = isDisabilitySearch
  }
  
  func rankings() -> [Ranking] {
    let rankings: [Ranking] = document.css("#cphBody_lblCachedRankingList tr").flatMap { (ranking) in
      guard ranking.className != "rankinglisttitle",
        ranking.className != "rankinglistheadings",
        var athleteID = ranking.css("a[href]").first?.toHTML?.digitsOnly else { return nil }
      if isDisabilitySearch {
        let endIndex = athleteID.index(athleteID.endIndex, offsetBy: -5)
        athleteID = String(athleteID[athleteID.startIndex...endIndex])
      }
      let rankingComponents = ranking.css("td")
      let rankingItem = Ranking(components: rankingComponents, athleteID: athleteID)
      return rankingItem.athleteName.isEmpty ? nil : rankingItem
    }
    return rankings
  }
  
}
