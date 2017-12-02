//
//  CollapsableErrorView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 28/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

final class CollapsableErrorView: UIView {
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textColor = .white
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.text = """
    Sorry, something went wrong!
    Please try again.
    """
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    backgroundColor = .potRed
    addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 32),
      label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 32)
      ])
  }
  
}
