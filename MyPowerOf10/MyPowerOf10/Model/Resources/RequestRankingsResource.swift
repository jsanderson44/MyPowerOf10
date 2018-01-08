//
//  RequestRankingsResource.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

struct RankingSearchRequest {
  let year: RankingQueryItem
  let region: RankingQueryItem
  let gender: Gender
  let ageGroup: RankingQueryItem
  let event: RankingQueryItem
}

struct RequestRankingsResource: NetworkResourceType, DataResourceType {
  
  typealias Model = [Ranking]
  public let httpRequestMethod: HTTPMethod = .post
  var url: URL
  var queryItems: [URLQueryItem]?
  
  private let rankingSearchRequest: RankingSearchRequest
  private var baseQueryItems: [URLQueryItem] {
    return [
    URLQueryItem(name: "event", value: rankingSearchRequest.event.searchQuery),
    URLQueryItem(name: "agegroup", value: rankingSearchRequest.ageGroup.searchQuery),
    URLQueryItem(name: "sex", value: rankingSearchRequest.gender.searchValue),
    URLQueryItem(name: yearQuery, value: rankingSearchRequest.year.searchQuery)
    ]
  }
  private var yearQuery: String {
    return rankingSearchRequest.year.searchQuery == "y" ? "alltime" : "year"
  }
  
  init(rankingSearchRequest: RankingSearchRequest) {
    self.rankingSearchRequest = rankingSearchRequest
    url = Config.baseURL.appendingPathComponent("rankings/rankinglist.aspx")
    queryItems = baseQueryItems
    
    if rankingSearchRequest.ageGroup.displayName == "Disability" {
      let disabilityQueryItem = URLQueryItem(name: "class", value: "all")
      queryItems?.append(disabilityQueryItem)
    }
    
    if rankingSearchRequest.region.searchQuery != "0" {
      let regionQueryItem = URLQueryItem(name: "areaid", value: rankingSearchRequest.region.searchQuery)
      queryItems?.append(regionQueryItem)
    }
  }
  
  func model(from data: Data) throws -> Model {
    let parser = try RankingsSearchHTMLParser(htmlData: data, isDisabilitySearch: rankingSearchRequest.ageGroup.displayName == "Disability")
    return parser.rankings()
  }
  
}
