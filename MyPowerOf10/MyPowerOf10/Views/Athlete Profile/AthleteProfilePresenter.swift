//
//  AthleteProfilePresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol AthleteProfilePresenterView: class {
  func updateWith(athleteProfile: AthleteProfile)
}

/// Handles the presentation of an Athlete Profile
final class AthleteProfilePresenter {
	
	// MARK: Internal
	
	weak var view: AthleteProfilePresenterView?
	
	// MARK: Private
	
	private let queue: OperationQueue
  private let athleteProfile: AthleteProfile
	
	// MARK: - Initialiers -
	
  init(athleteProfile: AthleteProfile, queue: OperationQueue = OperationQueue.main) {
    self.athleteProfile = athleteProfile
		self.queue = queue
	}
  
  // MARK: Internal
  
  func requestProfile() {
    view?.updateWith(athleteProfile: athleteProfile)
  }
	
}
