//
//  AthleteSearchResultsViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol AthleteSearchResultsViewPresenterDelegate: class {
  func updateWithResults(results: [AthleteResult])
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool)
  func didRecieveAthleteProfile(profile: AthleteProfile)
}

/// Handles the presentation of the Athlete Search results
final class AthleteSearchResultsViewPresenter {
  
  public typealias RequestAthleteProfileResourceService = GenericNetworkDataResourceService<RequestAthleteProfileResource>
  private typealias RequestAthleteProfileOperation = ResourceOperation<RequestAthleteProfileResourceService>
  
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
  
  func didSelectCell(at indexPath: IndexPath, service: RequestAthleteProfileResourceService = RequestAthleteProfileResourceService()) {
    delegate?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: true)
    guard let athleteID = athleteResults[indexPath.row].athleteID else { return }
    let resource = RequestAthleteProfileResource(athleteID: athleteID)
    let athleteSearchOperation = RequestAthleteProfileOperation(resource: resource, service: service) { (_, result) in
      self.delegate?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
      self.handleRequestAthleteProfileRequest(result)
    }
    queue.addOperation(athleteSearchOperation)
  }
  
  // MARK: Private
  
  private func handleRequestAthleteProfileRequest(_ result: NetworkResponse<RequestAthleteProfileResource.Model>) {
    switch result {
    case .failure:
      print("FAILLLLL")
    // TODO Error state
    case .success(let profile, _):
      delegate?.didRecieveAthleteProfile(profile: profile)
    }
  }
  
}
