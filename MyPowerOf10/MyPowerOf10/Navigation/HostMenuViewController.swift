//
//  HostMenuViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 30/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class TestMenuVC: MenuViewController {
  
  init() {
    super.init(nibName: String(describing: TestMenuVC.self), bundle: Bundle(for: TestMenuVC.self))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

import UIKit
import InteractiveSideMenu

/*
 HostViewController is container view controller, contains menu controller and the list of relevant view controllers.
 Responsible for creating and selecting menu items content controlers.
 Has opportunity to show/hide side menu.
 */
//TODO: Move this to Base
class HostViewController: MenuContainerViewController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let screenSize: CGRect = UIScreen.main.bounds
//    self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
    
    // Instantiate menu view controller by identifier
    self.menuViewController = TestMenuVC()
    
    // Gather content items controllers
    self.contentViewControllers = contentControllers()
    
    // Select initial content controller. It's needed even if the first view controller should be selected.
    self.selectContentViewController(contentViewControllers.first!)
  }
  
//  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//    super.viewWillTransition(to: size, with: coordinator)
//
//    /*
//     Options to customize menu transition animation.
//     */
//    var options = TransitionOptions()
//
//    // Animation duration
//    options.duration = size.width < size.height ? 0.4 : 0.6
//
//    // Part of item content remaining visible on right when menu is shown
//    options.visibleContentWidth = size.width / 6
//    self.transitionOptions = options
//  }
  
  private func contentControllers() -> [UIViewController] {
//    let controllersIdentifiers = ["Kitty", "TabBar"]
    var contentList = [UIViewController]()
    
    let router = MyPoTRouter()
    contentList.append(router)
    
    /*
     Instantiate items controllers from storyboard.
     */
//    for identifier in controllersIdentifiers {
//      if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
//        contentList.append(viewController)
//      }
//    }
    
    return contentList
  }
}
