//
//  RankingsSearchPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader
import HapticGenerator
import Po10Model

protocol RankingsSearchPresenterView: class {
  func presenterDidReceiveYears(years: [RankingSearchRequest.RankingQueryItem])
  func presenterDidReceiveRegions(regions: [RankingSearchRequest.RankingQueryItem])
  func presenterDidReceiveAgeGroups(ageGroups: [RankingSearchRequest.RankingQueryItem])
  func presenterDidRecieveEvents(events: [RankingSearchRequest.RankingQueryItem])
  
  func updateLoadingState(isLoading: Bool)
  func updateSearchButton(isEnabled: Bool)
  func updateErrorState(isVisible: Bool)
  
  func didRecieveRankings(rankings: [Ranking], request: RankingSearchRequest)
}

/// Handles the presentation of the Rankings Search functionality
final class RankingsSearchPresenter {
  
  public typealias RequestRankingsResourceService = GenericNetworkDataResourceService<RequestRankingsResource>
  private typealias RequestRankingsOperation = ResourceOperation<RequestRankingsResourceService>
  
  // MARK: Internal
  
  weak var view: RankingsSearchPresenterView?
  
  // MARK: Private
  
  private let queue: OperationQueue
  private let vendor: RankingQueryItemsVender
  
  // MARK: Public
  
  var selectedGender: Gender = .male {
    didSet {
      updateActionButtonIfNeeded()
      fetchEventsFor(ageGroup: selectedAgeGroup, gender: selectedGender)
    }
  }
  var selectedAgeGroup: RankingSearchRequest.RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
      fetchEventsFor(ageGroup: selectedAgeGroup, gender: selectedGender)
    }
  }
  var selectedYear: RankingSearchRequest.RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  var selectedRegion: RankingSearchRequest.RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  var selectedEvent: RankingSearchRequest.RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = PoTQueue.sharedQueue, vendor: RankingQueryItemsVender = RankingQueryItemsVender()) {
    self.queue = queue
    self.vendor = vendor
  }
  
  // MARK: Internal
  
  func fetchRankingQueryItems() {
    fetchYears()
    fetchRegions()
    fetchAgeGroups()
  }
  
  func requestRanking(service: RequestRankingsResourceService = RequestRankingsResourceService()) {
    guard let year = selectedYear, let region = selectedRegion, let ageGroup = selectedAgeGroup, let event = selectedEvent else { return }
    view?.updateLoadingState(isLoading: true)
    let rankingSearchRequest = RankingSearchRequest(year: year, region: region, gender: selectedGender, ageGroup: ageGroup, event: event)
    
    let resource = RequestRankingsResource(rankingSearchRequest: rankingSearchRequest)
    let requestRankingsOperation = RequestRankingsOperation(resource: resource, service: service) { (_, result) in
      self.view?.updateErrorState(isVisible: false)
      self.view?.updateLoadingState(isLoading: false)
      self.handleRequestRankingsResult(result, rankingRequest: rankingSearchRequest)
    }
    queue.addOperation(requestRankingsOperation)
  }
  
  // MARK: Private functions
  
  private func updateActionButtonIfNeeded() {
    guard selectedAgeGroup != nil,
      selectedYear != nil,
      selectedEvent != nil,
      selectedRegion != nil else {
        view?.updateSearchButton(isEnabled: false)
        return
    }
    view?.updateSearchButton(isEnabled: true)
  }
  
  private func fetchEventsFor(ageGroup: RankingSearchRequest.RankingQueryItem?, gender: Gender) {
    let events = vendor.events(forAgeGroup: ageGroup, andGender: gender)
    selectedEvent = events.first
    view?.presenterDidRecieveEvents(events: events)
  }
  
  private func fetchYears() {
    let years = vendor.years()
    selectedYear = years.first
    view?.presenterDidReceiveYears(years: years)
  }
  
  private func fetchRegions() {
    let regions = vendor.rankingQueryItems(forPlist: .regions)
    selectedRegion = regions.first
    view?.presenterDidReceiveRegions(regions: regions)
  }
  
  private func fetchAgeGroups() {
    let ageGroups = vendor.rankingQueryItems(forPlist: .ageGroups)
    selectedAgeGroup = ageGroups.first
    view?.presenterDidReceiveAgeGroups(ageGroups: ageGroups)
  }
  
  private func handleRequestRankingsResult(_ result: NetworkResponse<RequestRankingsResource.Model>, rankingRequest: RankingSearchRequest) {
    switch result {
    case .failure:
      Haptic.error.generate()
      view?.updateErrorState(isVisible: true)
    case .success(let rankings, _):
      if rankings.count > 0 {
        var top50: [Ranking] = []
        let finalIndex = rankings.count < 50 ? rankings.count-1 : 49
        for index in 0...finalIndex {
          top50.append(rankings[index])
        }
        Haptic.success.generate()
        view?.didRecieveRankings(rankings: top50, request: rankingRequest) // TODO - no rankings
      }
    }
  }
  
}
