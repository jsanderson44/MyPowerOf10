//
//  RankingsSearchPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol RankingsSearchPresenterView: class {
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
  
  func fetchAgeGroups() {
    let ageGroups = vendor.rankingQueryItems(forRoot: .ageGroups)
    view?.presenterDidReceiveAgeGroups(ageGroups: ageGroups)
  }
	
}
