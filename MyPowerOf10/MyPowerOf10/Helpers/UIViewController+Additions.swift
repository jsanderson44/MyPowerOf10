//
//  UIViewController+Additions.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 22/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

extension UIViewController {
  
  /// Removes the title from the navigation bar's back button.
  /// To see no title on the back button on a view controller you must call this
  /// method on the previous view controller.
  func removeBackButtonTitle() {
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
}
