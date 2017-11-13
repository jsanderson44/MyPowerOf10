//
//  AthleteSearchViewPresenterTests.swift
//  MyPowerOf10Tests
//
//  Created by John Sanderson on 13/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import XCTest
@testable import MyPowerOf10

private class MockView: AthleteSearchViewPresenterDelegate {
  
  var onUpdateLoadingState: ((Bool) -> (Void))?
  var onShowError: (() -> (Void))?
  var onUpdateSearchButton: ((Bool) -> (Void))?
  var onDidRecieveResults: (([AthleteResult]) -> (Void))?
  
  func updateLoadingState(isLoading: Bool) {
    onUpdateLoadingState?(isLoading)
  }
  
  func showError() {
    onShowError?()
  }
  
  func updateSearchButton(isEnabled: Bool) {
    onUpdateSearchButton?(isEnabled)
  }
  
  func didRecieveResults(athletes: [AthleteResult]) {
    onDidRecieveResults?(athletes)
  }
}

class AthleteSearchViewPresenterTests: XCTestCase {
  
  private var testPresenter: AthleteSearchViewPresenter!
  
  override func setUp() {
    super.setUp()
    testPresenter = AthleteSearchViewPresenter(queue: OperationQueue())
  }

  func test_loadingStates_whenSearchTapped() {
    let mockView = MockView()
    testPresenter.delegate = mockView
    var callCount = 0
    let wait = expectation(description: "wait")
    
    mockView.onUpdateLoadingState = { (state) in
      callCount += 1
      if callCount == 1 {
        print(callCount)
        XCTAssertEqual(state, true)
      } else if callCount == 2 {
        print(callCount)
        XCTAssertEqual(state, false)
        wait.fulfill()
      }
    }
    
    let mockSession = MockURLSession(data: Data())
    let mockService = AthleteSearchViewPresenter.SubmitAthleteSearchResourceService(session: mockSession)
    
    testPresenter.performSearch(service: mockService)
    
    waitForExpectations(timeout: 1)
    XCTAssertEqual(callCount, 2)
  }
  
  func test_initialStateOfSeachButton() {
    XCTAssertEqual(testPresenter.shouldEnableSearchButton, false)
  }
  
  func test_searchButtonEnabled_whenHasAthleteSurname() {
    let mockView = MockView()
    testPresenter.delegate = mockView
    
    mockView.onUpdateSearchButton = { (state) in
      XCTAssertEqual(state, true)
    }
    
    testPresenter.athleteSurnameDidChange(to: "Sanderson")
  }
  
  func test_searchButtonEnabled_whenHasAthleteFirstName() {
    let mockView = MockView()
    testPresenter.delegate = mockView
    
    mockView.onUpdateSearchButton = { (state) in
      XCTAssertEqual(state, true)
    }
    
    testPresenter.athleteFirstNameDidChange(to: "John")
  }
  
  func test_searchButtonEnabled_whenHasAthleteClub() {
    let mockView = MockView()
    testPresenter.delegate = mockView
    
    mockView.onUpdateSearchButton = { (state) in
      XCTAssertEqual(state, true)
    }
    
    testPresenter.athleteClubDidChange(to: "Guildford")
  }
  
}
