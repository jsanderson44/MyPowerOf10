//
//  RankingsSearchPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol RankingsSearchPresenterView: class {
  func presenterDidReceiveYears(years: [RankingQueryItem])
  func presenterDidReceiveRegions(regions: [RankingQueryItem])
  func presenterDidReceiveAgeGroups(ageGroups: [RankingQueryItem])
  func presenterDidRecieveEvents(events: [RankingQueryItem])
  
  func updateLoadingState(isLoading: Bool)
  func updateSearchButton(isEnabled: Bool)
  func updateErrorState(isVisible: Bool)
  
  func didRecieveRankings(rankings: [Ranking])
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
  var selectedAgeGroup: RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
      fetchEventsFor(ageGroup: selectedAgeGroup, gender: selectedGender)
    }
  }
  var selectedYear: RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  var selectedRegion: RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  var selectedEvent: RankingQueryItem? {
    didSet {
      updateActionButtonIfNeeded()
    }
  }
  
  // MARK: - Initialiers -
  
  init(queue: OperationQueue = OperationQueue.main, vendor: RankingQueryItemsVender = RankingQueryItemsVender()) {
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
    
    if Config.isOfflineMode {
      let data = FileLoader.dataFrom(filename: "Rankings", fileType: "html")
      let parser = try! RankingsSearchHTMLParser(htmlData: data)
      let rankings = parser.rankings()
      handleRequestRankingsResult(.success(rankings, HTTPURLResponse()))
      return
    }
    
    guard let year = selectedYear, let region = selectedRegion, let ageGroup = selectedAgeGroup, let event = selectedEvent else { return }
    view?.updateLoadingState(isLoading: true)
    let rankingSearchRequest = RankingSearchRequest(year: year, region: region, gender: selectedGender, ageGroup: ageGroup, event: event)
    let resource = RequestRankingsResource(rankingSearchRequest: rankingSearchRequest)
    let requestRankingsOperation = RequestRankingsOperation(resource: resource, service: service) { (_, result) in
      self.view?.updateErrorState(isVisible: false)
      self.view?.updateLoadingState(isLoading: false)
      self.handleRequestRankingsResult(result)
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
  
  private func fetchEventsFor(ageGroup: RankingQueryItem?, gender: Gender) {
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
  
  private func handleRequestRankingsResult(_ result: NetworkResponse<RequestRankingsResource.Model>) {
    switch result {
    case .failure:
      view?.updateErrorState(isVisible: true)
    case .success(let rankings, _):
      if rankings.count > 0 {
        var top50: [Ranking] = []
        let finalIndex = rankings.count < 50 ? rankings.count-1 : 49
        for index in 0...finalIndex {
          top50.append(rankings[index])
        }
        view?.didRecieveRankings(rankings: top50) // TODO - no rankings
      }
    }
  }
  
}
