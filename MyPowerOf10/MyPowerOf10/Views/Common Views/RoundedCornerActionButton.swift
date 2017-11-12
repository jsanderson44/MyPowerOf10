//
//  RoundedCornerActionButton.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 12/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

class RoundedCornerActionButton: UIButton {
  
  // MARK: - Public properties
  public var isLoading: Bool = false {
    didSet {
      styleTitleLabel(isLoading: isLoading)
      if isLoading {
        loadingSpinner.startAnimating()
      } else {
        loadingSpinner.stopAnimating()
      }
    }
  }
  
  // MARK: - Private properties
  
  private lazy var loadingSpinner: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  // MARK: - Override properties
  public override var isEnabled: Bool {
    didSet {
      backgroundColor = isEnabled ? .potRed : .potLightGray
    }
  }
  
  // MARK: - Initialisers
  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    style()
  }
  
  // MARK: - Private functions
  private func style() {
    layer.cornerRadius = 8.0 // TODO default corner radius
    backgroundColor = .potRed
    styleTitleLabel(isLoading: false)
    layoutLoadingView()
  }
  
  private func styleTitleLabel(isLoading: Bool) {
    titleLabel?.font = .systemFont(ofSize: 24)
    let titleColor: UIColor = isLoading ? .clear : .white
    setTitleColor(titleColor, for: .normal)
  }
  
  private func layoutLoadingView() {
    addSubview(loadingSpinner)
    loadingSpinner.hidesWhenStopped = true
    NSLayoutConstraint.activate([
      loadingSpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      loadingSpinner.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
}
