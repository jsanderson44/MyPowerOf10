//
//  AthleteProfilePresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol AthleteProfilePresenterView: class {
  func updateWith(athleteProfile: AthleteProfile, isFavourited: Bool)
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
	
  init(athlete: Athlete, queue: OperationQueue = OperationQueue.main, dataStore: DataStoreType = DataStore()) {
    self.athlete = athlete
		self.queue = queue
    self.dataStore = dataStore
	}
  
  // MARK: Internal
  
  func requestProfile() {
    view?.updateWith(athleteProfile: athlete.profile, isFavourited: athlete.isFavourited)
  }
  
  func favouriteAthlete() {
    guard let id = athlete.searchResult.athleteID else {
      return
      //TODO Handle not being able to save
    }
    do {
      athlete.didToggleFavouriteState(isFavourited: true)
      try dataStore.storeAthlete(athlete, forKey: id)
    } catch { }
  }
  
  func unfavouriteAthlete() {
    guard let id = athlete.searchResult.athleteID else {
      return
      //TODO Handle not being able to remove
    }
    athlete.didToggleFavouriteState(isFavourited: false)
    dataStore.removeAthlete(forKey: id)
  }
	
}
