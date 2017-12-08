//
//  RequestAthleteProfileResource.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

struct RequestAthleteProfileResource: NetworkResourceType, DataResourceType {
  
  typealias Model = Athlete
  public let httpRequestMethod: HTTPMethod = .post
  var url: URL
  var queryItems: [URLQueryItem]? {
    let queryItems = [
      URLQueryItem(name: "athleteid", value: athleteID),
    ]
    return queryItems
  }
  
  private let athleteResult: AthleteResult
  private var athleteID: String {
    guard let athleteID = athleteResult.athleteID else {
      return ""
    }
    return athleteID
  }
  
  init(athleteResult: AthleteResult) {
    self.athleteResult = athleteResult
    url = Config.baseURL.appendingPathComponent("athletes/profile.aspx")
  }
  
  func model(from data: Data) throws -> Model {
    let parser = try AthleteProfileHTMLParser(htmlData: data)
    let profile = try parser.athleteProfile()
    return Athlete(searchResult: athleteResult, profile: profile, isFavourited: false)
  }
  
}
