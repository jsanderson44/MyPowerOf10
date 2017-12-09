//
//  AthleteSearchViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol AthleteSearchPresenterView: class {
  func updateLoadingState(isLoading: Bool)
  func updateErrorState(isVisible: Bool)
  func updateSearchButton(isEnabled: Bool)
  func didRecieveResults(athletes: [AthleteResult])
}

/// Handles the presentation of the Athlete Search functionality
final class AthleteSearchViewPresenter {
  
  public typealias SubmitAthleteSearchResourceService = GenericNetworkDataResourceService<SubmitAthleteSearchResource>
  private typealias SubmitAthleteSearchOperation = ResourceOperation<SubmitAthleteSearchResourceService>
  
  // MARK: Internal
  
  weak var view: AthleteSearchPresenterView?
  
  // MARK: Private
  
  private let queue: OperationQueue
  private var athleteSurname: String = ""
  private var athleteFirstName: String = ""
  private var athleteClub: String = ""
  var shouldEnableSearchButton: Bool {
    return (athleteSurname != "") || (athleteFirstName != "") || (athleteClub != "")
  }
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = OperationQueue.main) {
    self.queue = queue
  }
  
  // MARK: - Internal
  
  func performSearch(service: SubmitAthleteSearchResourceService = SubmitAthleteSearchResourceService()) {
    view?.updateLoadingState(isLoading: true)
    let resource = SubmitAthleteSearchResource(firstname: athleteFirstName, surname: athleteSurname, club: athleteClub)
    let athleteSearchOperation = SubmitAthleteSearchOperation(resource: resource, service: service) { (_, result) in
      self.view?.updateLoadingState(isLoading: false)
      self.view?.updateErrorState(isVisible: false)
      self.handleAthleteSearchResult(result)
    }
    queue.addOperation(athleteSearchOperation)
  }
  
  func athleteSurnameDidChange(to value: String) {
    athleteSurname = value.trimmingCharacters(in: .whitespaces)
    view?.updateSearchButton(isEnabled: shouldEnableSearchButton)
  }
  
  func athleteFirstNameDidChange(to value: String) {
    athleteFirstName = value.trimmingCharacters(in: .whitespaces)
    view?.updateSearchButton(isEnabled: shouldEnableSearchButton)
  }
  
  func athleteClubDidChange(to value: String) {
    athleteClub = value.trimmingCharacters(in: .whitespaces)
    view?.updateSearchButton(isEnabled: shouldEnableSearchButton)
  }
  
  // MARK: - Private
  
  private func handleAthleteSearchResult(_ result: NetworkResponse<SubmitAthleteSearchResource.Model>) {
    switch result {
    case .failure:
      view?.updateErrorState(isVisible: true)
    case .success(let athletes, _):
      view?.didRecieveResults(athletes: athletes)
    }
  }
    
}
