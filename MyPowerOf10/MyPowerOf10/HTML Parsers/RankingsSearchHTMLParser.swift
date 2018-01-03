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
  
  init(htmlData: Data) throws {
    let document = try HTML(html: htmlData, encoding: .utf8)
    self.document = document
  }
  
  func rankings() -> [Ranking] {
    let rankings: [Ranking] = document.css("#cphBody_lblCachedRankingList tr").flatMap { (ranking) in
      guard (ranking.className != "rankinglisttitle") || (ranking.className != "rankinglistheadings"),
        let athleteID = ranking.css("a[href]").first?.toHTML?.digitsOnly else { return nil }
      let rankingComponents = ranking.css("td")
      let rankingItem = Ranking(components: rankingComponents, athleteID: athleteID)
      return rankingItem.athleteName.isEmpty ? nil : rankingItem
    }
    return rankings
  }
  
}
