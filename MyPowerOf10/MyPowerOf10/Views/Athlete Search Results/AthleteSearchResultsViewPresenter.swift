//
//  AthleteSearchResultsViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol AthleteSearchResultsPresenterView: class {
  func updateWithResults(results: [AthleteResult])
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool)
  func didRecieveAthlete(athlete: Athlete)
}

/// Handles the presentation of the Athlete Search results
final class AthleteSearchResultsViewPresenter {
  
  public typealias RequestAthleteProfileResourceService = GenericNetworkDataResourceService<RequestAthleteProfileResource>
  private typealias RequestAthleteProfileOperation = ResourceOperation<RequestAthleteProfileResourceService>
  
  // MARK: Internal
  
  weak var view: AthleteSearchResultsPresenterView?
  
  // MARK: Private
  
  private let queue: OperationQueue
  private let dataStore: DataStoreType
  private let athleteResults: [AthleteResult]
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = OperationQueue.main, dataStore: DataStoreType = DataStore(), athleteResults: [AthleteResult]) {
    self.queue = queue
    self.dataStore = dataStore
    self.athleteResults = athleteResults
  }
  
  // MARK: - Internal
  
  func requestResults() {
    view?.updateWithResults(results: athleteResults)
  }
  
  func didSelectCell(at indexPath: IndexPath, service: RequestAthleteProfileResourceService = RequestAthleteProfileResourceService()) {
    view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: true)
    let athleteResult = athleteResults[indexPath.row]
    if let savedAthlete = favouritedAthlete(athleteResult: athleteResult) {
      view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
      view?.didRecieveAthlete(athlete: savedAthlete)
    } else {
      let resource = RequestAthleteProfileResource(athleteResult: athleteResult)
      let athleteSearchOperation = RequestAthleteProfileOperation(resource: resource, service: service) { (_, result) in
        self.view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
        self.handleRequestAthleteProfileRequest(result)
      }
      queue.addOperation(athleteSearchOperation)
    }
  }
  
  // MARK: Private
  
  private func favouritedAthlete(athleteResult: AthleteResult) -> Athlete? {
    guard let id = athleteResult.athleteID else {
      return nil
    }
    do {
      let savedAthlete = try dataStore.retrieveAthlete(forKey: id)
      return savedAthlete
    } catch {
      return nil
    }
  }
  
  private func handleRequestAthleteProfileRequest(_ result: NetworkResponse<RequestAthleteProfileResource.Model>) {
    switch result {
    case .failure:
      print("FAILLLLL")
    // TODO Error state
    case .success(let athlete, _):
      view?.didRecieveAthlete(athlete: athlete)
    }
  }
  
}
