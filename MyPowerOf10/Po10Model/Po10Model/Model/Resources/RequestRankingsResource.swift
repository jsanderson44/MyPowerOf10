//
//  RequestRankingsResource.swift
//  Po10Model
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

public struct RankingSearchRequest {
  
  public struct RankingQueryItem: Decodable {
    public let displayName: String
    public let searchQuery: String
    
    public init(displayName: String, searchQuery: String) {
      self.displayName = displayName
      self.searchQuery = searchQuery
    }
  }
  
  public let year: RankingQueryItem
  public let region: RankingQueryItem
  public let gender: Gender
  public let ageGroup: RankingQueryItem
  public let event: RankingQueryItem
  
  public init(year: RankingQueryItem, region: RankingQueryItem, gender: Gender, ageGroup: RankingQueryItem, event: RankingQueryItem) {
    self.year = year
    self.region = region
    self.gender = gender
    self.ageGroup = ageGroup
    self.event = event
  }
}

public struct RequestRankingsResource: NetworkResourceType, DataResourceType {
  
  public typealias Model = [Ranking]
  public let httpRequestMethod: HTTPMethod = .post
  public var url: URL
  public var queryItems: [URLQueryItem]?
  
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
  
  public init(rankingSearchRequest: RankingSearchRequest) {
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
  
  public func model(from data: Data) throws -> Model {
    let parser = try RankingsSearchHTMLParser(htmlData: data, isDisabilitySearch: rankingSearchRequest.ageGroup.displayName == "Disability")
    return parser.rankings()
  }
  
}
