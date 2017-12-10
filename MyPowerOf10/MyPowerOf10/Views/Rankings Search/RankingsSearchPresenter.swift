//
//  RankingsSearchPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol RankingsSearchPresenterView: class {
  func presenterDidReceiveYears(years: [RankingQueryItem])
  func presenterDidReceiveRegions(regions: [RankingQueryItem])
  func presenterDidReceiveAgeGroups(ageGroups: [RankingQueryItem])
}

/// Handles the presentation of the Rankings Search functionality
final class RankingsSearchPresenter {
  
	// MARK: Internal
	
	weak var view: RankingsSearchPresenterView?
	
	// MARK: Private
	
	private let queue: OperationQueue
  private let vendor: RankingQueryItemsVender
  private var events: [RankingQueryItem] = []
	
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
  
  // MARK: Private functions
  
  private func fetchYears() {
    let years = vendor.years()
    view?.presenterDidReceiveYears(years: years)
  }
  
  private func fetchRegions() {
    let regions = vendor.rankingQueryItems(forPlist: .regions)
    view?.presenterDidReceiveRegions(regions: regions)
  }
  
  private func fetchAgeGroups() {
    let ageGroups = vendor.rankingQueryItems(forPlist: .ageGroups)
    view?.presenterDidReceiveAgeGroups(ageGroups: ageGroups)
  }
	
}
