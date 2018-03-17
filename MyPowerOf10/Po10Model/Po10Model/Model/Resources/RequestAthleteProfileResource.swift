//
//  RequestAthleteProfileResource.swift
//  Po10Model
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

public struct RequestAthleteProfileResource: NetworkResourceType, DataResourceType {
  
  public typealias Model = Athlete
  public let httpRequestMethod: HTTPMethod = .post
  public var url: URL
  public var queryItems: [URLQueryItem]? {
    let queryItems = [
      URLQueryItem(name: "athleteid", value: athleteID),
    ]
    return queryItems
  }
  
  private let athleteID: String
  
  public init(athleteID: String?) {
    self.athleteID = athleteID ?? ""
    url = Config.baseURL.appendingPathComponent("athletes/profile.aspx")
  }
  
  public func model(from data: Data) throws -> Model {
    let parser = try AthleteProfileHTMLParser(htmlData: data, athleteID: athleteID)
    let profile = try parser.athleteProfile()
    return profile
  }
  
}
