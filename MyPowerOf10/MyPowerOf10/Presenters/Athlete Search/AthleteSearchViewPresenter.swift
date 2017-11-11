//
//  AthleteSearchViewPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol AthleteSearchViewPresenterDelegate: class {
  func updateLoadingState()
  func showError()
  func updateSearchButton(isEnabled: Bool)
  func didRecieveResults(athletes: [AthleteResult])
}

/// Handles the presentation of the Athlete Search functionality
final class AthleteSearchViewPresenter {
  
  public typealias SubmitAthleteSearchResourceService = GenericNetworkDataResourceService<SubmitAthleteSearchResource>
  private typealias SubmitAthleteSearchOperation = ResourceOperation<SubmitAthleteSearchResourceService>
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchViewPresenterDelegate?
  
  // MARK: Private
  
  private let queue: OperationQueue
  private var athleteSurname: String = ""
  private var athleteFirstName: String = ""
  private var athleteClub: String = ""
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = OperationQueue.main) {
    self.queue = queue
  }
  
  // MARK: - Internal
  
  func performSearch() {
    let resource = SubmitAthleteSearchResource(firstname: athleteFirstName, surname: athleteSurname, club: athleteClub)
    let service = SubmitAthleteSearchResourceService()
    let athleteSearchOperation = SubmitAthleteSearchOperation(resource: resource, service: service) { (_, result) in
      self.handleAthleteSearchResult(result)
    }
    queue.addOperation(athleteSearchOperation)
  }
  
  func athleteSurnameDidChange(to value: String) {
    athleteSurname = value
  }
  
  func athleteFirstNameDidChange(to value: String) {
    athleteFirstName = value
  }
  
  func athleteClubDidChange(to value: String) {
    athleteClub = value
  }
  
  // MARK: - Private
  
  private func handleAthleteSearchResult(_ result: NetworkResponse<SubmitAthleteSearchResource.Model>) {
    switch result {
    case .failure:
      print("FAILLLLL")
      // TODO Error state
    case .success(let athletes, _):
      delegate?.didRecieveResults(athletes: athletes)
    }
  }
    
}
