//
//  UINavigationController+Additions.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 02/01/2018.
//  Copyright © 2018 JohnSanderson. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  func style() {
    navigationBar.tintColor = .potRed
    if #available(iOS 11.0, *) {
      navigationBar.prefersLargeTitles = true
      navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
      navigationItem.largeTitleDisplayMode = .always
    }
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.potDarkGray]
  }
  
}
