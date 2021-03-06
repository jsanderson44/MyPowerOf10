//
//  AthleteSearchResultsViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader
import HapticGenerator
import Po10Model

enum AthleteListContext {
  case searchResults
  case favorites
}

protocol AthleteSearchResultsPresenterView: class {
  func updateWithResults(results: [AthleteResult])
  func updateWithNoResultsMessage(message: String)
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool)
  func updateErrorState(isVisible: Bool)
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
  private let context: AthleteListContext
  private var athleteResults: [AthleteResult]
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = PoTQueue.sharedQueue, dataStore: DataStoreType = DataStore(), athleteResults: [AthleteResult] = [], context: AthleteListContext) {
    self.queue = queue
    self.dataStore = dataStore
    self.context = context
    self.athleteResults = athleteResults
  }
  
  // MARK: - Internal
  
  func requestResults() { //TODO refactor this
    if context == .favorites {
      athleteResults = []
      dataStore.retrieveAllAthletes().forEach { athlete in
        let athleteResult = AthleteResult(athlete: athlete)
        athleteResults.append(athleteResult)
      }
    }
    
    if athleteResults.count > 0 {
      view?.updateWithResults(results: athleteResults)
    } else {
      let noResultsMessage = context == .searchResults ? "Sorry, no results.\n\nPlease try another search." : "No favourites.\n\nTo favourite an athlete tap the star in the top right of their profile."
      view?.updateWithNoResultsMessage(message: noResultsMessage)
    }
  }
  
  func didSelectCell(at indexPath: IndexPath, service: RequestAthleteProfileResourceService = RequestAthleteProfileResourceService()) {
    view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: true)
    view?.updateErrorState(isVisible: false)
    let athleteResult = athleteResults[indexPath.row]
    if let savedAthlete = favouritedAthlete(athleteResult: athleteResult) {
      Haptic.success.generate()
      view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
      view?.didRecieveAthlete(athlete: savedAthlete)
    } else {
      let resource = RequestAthleteProfileResource(athleteID: athleteResult.athleteID)
      let athleteSearchOperation = RequestAthleteProfileOperation(resource: resource, service: service) { (_, result) in
        self.view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
        self.view?.updateErrorState(isVisible: false)
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
      Haptic.error.generate()
      view?.updateErrorState(isVisible: true)
    case .success(let athlete, _):
      Haptic.success.generate()
      view?.didRecieveAthlete(athlete: athlete)
    }
  }
  
}
