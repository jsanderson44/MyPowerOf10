//
//  RequestRankingsResource.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

struct RequestRankingsResource: NetworkResourceType, DataResourceType {
  
  typealias Model = [String] //TODO Ranking model
  public let httpRequestMethod: HTTPMethod = .post
  var url: URL
  var queryItems: [URLQueryItem]? {
    let queryItems = [
      URLQueryItem(name: "event", value: event),
      URLQueryItem(name: "agegroup", value: ageGroup),
      URLQueryItem(name: "sex", value: gender.searchValue),
      URLQueryItem(name: "year", value: year),
      URLQueryItem(name: "alltime", value: year), //TODO
      URLQueryItem(name: "areaid", value: event)
      ]
    return queryItems
  }
  
  private let year: String
  private let region: String
  private let gender: Gender
  private let ageGroup: String
  private let event: String
  
  init(year: String, region: String, gender: Gender, ageGroup: String, event: String) {
    self.year = year
    self.region = region
    self.gender = gender
    self.ageGroup = ageGroup
    self.event = event
    url = Config.baseURL.appendingPathComponent("rankings/rankinglist.aspx")
  }
  
  func model(from data: Data) throws -> Model {
    return []
  }
  
}
