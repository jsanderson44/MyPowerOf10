//
//  SubmitAthleteSearchResource.swift
//  Po10Model
//
//  Created by John Sanderson on 06/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

public struct SubmitAthleteSearchResource: NetworkResourceType, DataResourceType {
  
  public typealias Model = [AthleteResult]
  public let httpRequestMethod: HTTPMethod = .post
  public var url: URL
  public var queryItems: [URLQueryItem]? {
    let queryItems = [
      URLQueryItem(name: "surname", value: surname),
      URLQueryItem(name: "firstname", value: firstname),
      URLQueryItem(name: "club", value: club)
    ]
    
    return queryItems
  }
  
  private let firstname: String
  private let surname: String
  private let club: String
  
  public init(firstname: String, surname: String, club: String) {
    self.firstname = firstname
    self.surname = surname
    self.club = club
    url = Config.baseURL.appendingPathComponent("athletes/athleteslookup.aspx")
  }
  
  public func model(from data: Data) throws -> Model {
    let parser = try AthleteSearchHTMLParser(htmlData: data)
    return parser.athletesFromSearchResults()
  }
  
}
