//
//  BaseViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class BaseViewController: UIViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let router = MyPoTRouter()
    present(router, animated: false)
  }
  
}
