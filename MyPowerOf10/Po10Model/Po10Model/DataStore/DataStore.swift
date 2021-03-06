//
//  DataStore.swift
//  Po10Model
//
//  Created by John Sanderson on 07/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

public enum DataStoreError: Error {
  case couldNotDecodeData
}

/// Used to store, retrieve and remove values from the keychain
public struct DataStore: DataStoreType {
  
  // MARK: - Private properties
  private let store: UserDefaults
  
  // MARK: - Initialiser
  public init(store: UserDefaults = UserDefaults.standard) {
    self.store = store
  }
  
  // MARK: - DataStoreType conformance
  public func storeAthlete(_ athlete: Athlete, forKey key: String) throws {
    let jsonEncoder = JSONEncoder()
    let jsonData = try jsonEncoder.encode(athlete)
    store.set(jsonData, forKey: key)
  }
  
  public func retrieveAthlete(forKey key: String) throws -> Athlete {
    let jsonDecoder = JSONDecoder()
    guard let jsonData = store.value(forKey: key) as? Data else {
      throw DataStoreError.couldNotDecodeData
    }
    let athlete = try jsonDecoder.decode(Athlete.self, from: jsonData)
    return athlete
  }
  
  public func retrieveAllAthletes() -> [Athlete] {
    let jsonDecoder = JSONDecoder()
    let jsonDictionary = store.dictionaryRepresentation()
    var athletes: [Athlete] = []
    do {
      try jsonDictionary.forEach {
        guard let data = $0.value as? Data else { return }
        let athlete = try jsonDecoder.decode(Athlete.self, from: data)
        athletes.append(athlete)
      }
    } catch {
      return athletes
    }
    return athletes
  }
  
  public func removeAthlete(forKey key: String) {
    store.removeObject(forKey: key)
  }
  
}
