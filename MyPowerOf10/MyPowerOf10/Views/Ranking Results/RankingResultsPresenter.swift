//
//  RankingResultsPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 01/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

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
	
  init(queue: OperationQueue = OperationQueue(), rankings: [Ranking], request: RankingSearchRequest, dataStore: DataStoreType = DataStore()) {
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
  
  func didSelectCell(at indexPath: IndexPath, service: RequestAthleteProfileResourceService = RequestAthleteProfileResourceService()) {
    view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: true)
//    TODO Make ranking model contain athlete
    let ranking = rankings[indexPath.row]
    if let savedAthlete = favouritedAthlete(ranking: ranking) {
      view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
//      view?.updateErrorState(isVisible: false)
      view?.presenterDidRecieveAthlete(athlete: savedAthlete)
    } else {
      let resource = RequestAthleteProfileResource(ranking: ranking)
      let athleteSearchOperation = RequestAthleteProfileOperation(resource: resource, service: service) { (_, result) in
        self.view?.updateLoadingState(forCellAtIndexPath: indexPath, isLoading: false)
//        self.view?.updateErrorState(isVisible: false)
        self.handleRequestAthleteProfileRequest(result)
      }
      queue.addOperation(athleteSearchOperation)
    }
  }
	
  // MARK: - Private functions
  
  private func favouritedAthlete(ranking: Ranking) -> Athlete? {
    do {
      let savedAthlete = try dataStore.retrieveAthlete(forKey: ranking.athleteID)
      return savedAthlete
    } catch {
      return nil
    }
  }
  
  private func handleRequestAthleteProfileRequest(_ result: NetworkResponse<RequestAthleteProfileResource.Model>) {
    switch result {
    case .failure:
      break
//      view?.updateErrorState(isVisible: true)
    case .success(let athlete, _):
      view?.presenterDidRecieveAthlete(athlete: athlete)
    }
  }
}
