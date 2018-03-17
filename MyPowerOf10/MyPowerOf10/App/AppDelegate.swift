//
//  AppDelegate.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = BaseViewController()
    window?.makeKeyAndVisible()
    
    Po10Model.Config.baseURL = Config.baseURL
    
    return true
  }
  
}

