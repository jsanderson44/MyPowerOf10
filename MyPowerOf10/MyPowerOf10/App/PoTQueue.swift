//
//  PoTQueue.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 02/02/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import Foundation

final class PoTQueue: OperationQueue {
  
  static let sharedQueue = PoTQueue()
  
  override init() {
    super.init()
    maxConcurrentOperationCount = 1
  }
  
}
