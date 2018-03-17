//
//  AthleteProfilePresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Po10Model

protocol AthleteProfilePresenterView: class {
  func updateWith(athlete: Athlete)
}

/// Handles the presentation of an Athlete Profile
final class AthleteProfilePresenter {
	
	// MARK: Internal
	
	weak var view: AthleteProfilePresenterView?
	
	// MARK: Private
	
	private let queue: OperationQueue
  private let dataStore: DataStoreType
  private var athlete: Athlete
	
	// MARK: - Initialiers -
	
  init(athlete: Athlete, queue: OperationQueue = PoTQueue.sharedQueue, dataStore: DataStoreType = DataStore()) {
    self.athlete = athlete
		self.queue = queue
    self.dataStore = dataStore
	}
  
  // MARK: Internal
  
  func requestProfile() {
    view?.updateWith(athlete: athlete)
  }
  
  func favouriteAthlete() {
    athlete.didToggleFavouriteState(isFavourited: true)
    try? dataStore.storeAthlete(athlete, forKey: athlete.athleteID)
  }
  
  func unfavouriteAthlete() {
    athlete.didToggleFavouriteState(isFavourited: false)
    dataStore.removeAthlete(forKey: athlete.athleteID)
  }
	
}
