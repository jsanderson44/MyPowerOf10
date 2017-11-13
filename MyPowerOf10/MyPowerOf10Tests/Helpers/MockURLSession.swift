//
//  MockURLSession.swift
//  MyPowerOf10Tests
//
//  Created by John Sanderson on 13/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
@testable import TABResourceLoader

final class MockTask: URLSessionDataTask {
  var isCancelled = false
  override func cancel() {
    isCancelled = true
  }
}

class MockURLSession: URLSessionType {
  
  private let data: Data
  
  init(data: Data) {
    self.data = data
  }
  
  func perform(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    let task = MockTask()
    
    if task.isCancelled {
      return task
    }
    
    guard let url = request.url else {
      completion(nil, HTTPURLResponse(), nil)
      return task
    }
    
    let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
    completion(data, response, nil)
    return task
  }
  
  func invalidateAndCancel() { }
}
