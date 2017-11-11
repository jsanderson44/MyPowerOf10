//
//  AthleteSearchResultsViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol AthleteSearchResultsViewPresenterDelegate: class {
  func updateWithResults(results: [AthleteResult])
}

/// Handles the presentation of the Athlete Search results
final class AthleteSearchResultsViewPresenter {
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchResultsViewPresenterDelegate?
  
  // MARK: Private
  
  private let queue: OperationQueue
  private let athleteResults: [AthleteResult]
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = OperationQueue.main, athleteResults: [AthleteResult]) {
    self.queue = queue
    self.athleteResults = athleteResults
  }
  
  // MARK: - Internal
  
  func requestResults() {
    delegate?.updateWithResults(results: athleteResults)
  }
  
}
