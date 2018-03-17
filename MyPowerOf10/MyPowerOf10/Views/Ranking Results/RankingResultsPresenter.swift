//
//  RankingResultsPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 01/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader
import HapticGenerator

protocol RankingResultsPresenterView: class {
  func presenterDidReceiveRankings(rankings: [Ranking], requestDisplayString: String)
  func presenterDidRecieveAthlete(athlete: Athlete)
  func updateLoadingState(forCellAtIndexPath indexPath: IndexPath, isLoading: Bool)
}

/// Deals with presentation of the RankingResultsViewController
final class RankingResultsPresenter {
  
  public typealias RequestAthleteProfileResourceService = GenericNetworkDataResourceService<RequestAthleteProfileResource>
  private typealias RequestAthleteProfileOperation = ResourceOperation<RequestAthleteProfileResourceService>
	
	// MARK: Internal
	
	weak var view: RankingResultsPresenterView?
	
	// MARK: Private
	
	private let queue: OperationQueue
  private let rankings: [Ranking]
  private let request: RankingSearchRequest
  private let dataStore: DataStoreType
	
	// MARK: - Initialiers -
	
  init(queue: OperationQueue = PoTQueue.sharedQueue, rankings: [Ranking], request: RankingSearchRequest, dataStore: DataStoreType = DataStore()) {
		self.queue = queue
    self.rankings = rankings
    self.request = request
    self.dataStore = dataStore
	}
  
  // MARK: - Internal
  
  func requestRankings() {
    let regionString = request.region.displayName == "UK" ? "" : "\(request.region.displayName) "
    let requestDisplayString = "\(request.year.displayName) \(regionString)\(request.ageGroup.displayName) \(request.gender.rawValue) \(request.event.displayName)"
    view?.presenterDidReceiveRankings(rankings: rankings, requestDisplayString: requestDisplayString)
  }
  
  func didSelectCell(at indexPath: IndexPath) {
    view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: true)
    let ranking = rankings[indexPath.row]
    if let savedAthlete = favouritedAthlete(ranking: ranking) {
      view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
      handleProfile(for: savedAthlete)
    } else {
      requestAthleteProfile(with: ranking.athleteID, indexPath: indexPath)
    }
  }
	
  // MARK: - Private functions
  
  private func favouritedAthlete(ranking: Ranking) -> Athlete? {
    return try? dataStore.retrieveAthlete(forKey: ranking.athleteID)
  }
  
  private func handleProfile(for savedAthlete: Athlete) {
    //      view?.updateErrorState(isVisible: false)
    view?.presenterDidRecieveAthlete(athlete: savedAthlete)
  }
  
  private func requestAthleteProfile(with athleteID: String, indexPath: IndexPath, service: RequestAthleteProfileResourceService = RequestAthleteProfileResourceService()) {
    let resource = RequestAthleteProfileResource(athleteID: athleteID)
    let athleteSearchOperation = RequestAthleteProfileOperation(resource: resource, service: service) { (_, result) in
      self.view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
      //        self.view?.updateErrorState(isVisible: false)
      self.handleRequestAthleteProfileRequest(result)
    }
    queue.addOperation(athleteSearchOperation)
  }
  
  private func handleRequestAthleteProfileRequest(_ result: NetworkResponse<RequestAthleteProfileResource.Model>) {
    switch result {
    case .failure:
      HapticGenerator.error.generateHaptic()
//      view?.updateErrorState(isVisible: true)
    case .success(let athlete, _):
      HapticGenerator.success.generateHaptic()
      view?.presenterDidRecieveAthlete(athlete: athlete)
    }
  }
}
