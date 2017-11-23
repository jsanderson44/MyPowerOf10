//
//  SubmitAthleteSearchResource.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 06/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

struct SubmitAthleteSearchResource: NetworkResourceType, DataResourceType {
  
  typealias Model = [AthleteResult]
  public let httpRequestMethod: HTTPMethod = .post
  var url: URL
  var queryItems: [URLQueryItem]? {
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
  
  init(firstname: String, surname: String, club: String) {
    self.firstname = firstname
    self.surname = surname
    self.club = club
    url = Config.baseURL.appendingPathComponent("athletes/athleteslookup.aspx")
  }
  
  func model(from data: Data) throws -> Model {
    let parser = try AthleteSearchHTMLParser(htmlData: data)
    return parser.athletesFromSearchResults()
  }
  
}
