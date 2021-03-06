//
//  AthleteSearchHTMLParser.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

struct AthleteSearchHTMLParser {
  
  let document: HTMLDocument
  
  init(htmlData: Data) throws {
    let document = try HTML(html: htmlData, encoding: .utf8)
    self.document = document
  }
  
  //TODO - Move trimming to here
  func athletesFromSearchResults() -> [AthleteResult] {
    let athletes: [AthleteResult] = document.css("#cphBody_dgAthletes tr").compactMap { (athlete) in
      guard let profileHTML = athlete.css("a[href]").first?.toHTML,
        var components = athlete.innerHTML?.components(separatedBy: .newlines) else { return nil }
      components.append(profileHTML)
      return AthleteResult(components: components)
    }
    return athletes
  }
  
}
