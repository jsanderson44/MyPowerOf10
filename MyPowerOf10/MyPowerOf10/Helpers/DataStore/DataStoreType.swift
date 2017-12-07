//
//  DataStoreType.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 07/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

protocol DataStoreType {
  
  /// Stores the specified string value
  /// with an associated key.
  ///
  /// - Parameters:
  ///   - value: The string value to store
  ///   - key: The associated key
  func storeAthlete(_ athlete: Athlete, forKey key: String) throws
  
  /// Returns a stored string value that
  /// is idetified by the specified key.
  /// Will return `nil` if no associated value is found
  ///
  /// - Parameter key: The key used to identify the value
  /// - Returns: The associated string value (optional)
  func retrieveAthlete(forKey key: String) throws -> Athlete
  
  /// Removes the persisted value identified by
  /// the provided key from.
  ///
  /// - Parameter key: The key used to identify the value
  func removeAthlete(forKey key: String)
  
}
