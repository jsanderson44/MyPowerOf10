//
//  UIViewController+Additions.swift
//  Po10UI
//
//  Created by John Sanderson on 22/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

public extension UIViewController {
  
  /// Removes the title from the navigation bar's back button.
  /// To see no title on the back button on a view controller you must call this
  /// method on the previous view controller.
  public func removeBackButtonTitle() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  /// Adds the app logo as the right bar button item of the `navigationItem`
  public func addLogoItemToNavigationBar() {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    imageView.image = UIImage(named: "roundedIcon")
    let rightBarButtonItem = UIBarButtonItem(customView: imageView)
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  public func configureMultilineNavigationTitle(title: String, subtitle: String) {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    let titleView = UIView()
    titleView.addSubview(label)
    label.pin(toView: titleView)
    let mainTitleAttributtedText = NSAttributedString(string: "\(title)\n", attributes: [.foregroundColor : UIColor.potDarkGray, .font : UIFont.systemFont(ofSize: 17, weight: .semibold)])
    let subtitleAttributtedText = NSAttributedString(string: subtitle, attributes: [.foregroundColor : UIColor.potDarkGray, .font : UIFont.systemFont(ofSize: 15, weight: .regular)])
    let mutableAttributedString = NSMutableAttributedString(attributedString: mainTitleAttributtedText)
    mutableAttributedString.append(subtitleAttributtedText)
    label.attributedText = mutableAttributedString
    navigationItem.titleView = titleView
  }
}
