//
//  AthleteProfileViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 23/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol AthleteProfileViewControllerDelegate: class {
	// TODO: Add delegate requirements
}

/// Handles the user interface for an Athlete Profile
final class AthleteProfileViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet private var toggleContainerView: UIView!
	
	// MARK: Internal
	
	weak var delegate: AthleteProfileViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: AthleteProfilePresenter
  private let toggleView = AthleteProfileToggleView.loadFromNib()
	
	// MARK: - Initialiers -
	
	init(delegate: AthleteProfileViewControllerDelegate, presenter: AthleteProfilePresenter) {
		self.presenter = presenter
		self.delegate = delegate
		super.init(nibName: String(describing: AthleteProfileViewController.self), bundle: Bundle(for: AthleteProfileViewController.self))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.view = self
    configureToggleView()
    presenter.requestProfile()
	}
  
  // MARK: Private
  
  private func configureToggleView() {
    toggleContainerView.addSubview(toggleView)
    toggleView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toggleView.topAnchor.constraint(equalTo: toggleContainerView.topAnchor),
      toggleView.bottomAnchor.constraint(equalTo: toggleContainerView.bottomAnchor),
      toggleView.leadingAnchor.constraint(equalTo: toggleContainerView.leadingAnchor),
      toggleView.trailingAnchor.constraint(equalTo: toggleContainerView.trailingAnchor)
      ])
  }
	
}

// MARK: AthleteProfilePresenterView

extension AthleteProfileViewController: AthleteProfilePresenterView {
	
  func updateWith(athleteProfile: AthleteProfile) {
    title = athleteProfile.name
  }
}
