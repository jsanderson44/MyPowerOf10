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
  @IBOutlet private var detailContainerView: UIView!
	
	// MARK: Internal
	
	weak var delegate: AthleteProfileViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: AthleteProfilePresenter
  private let toggleView = AthleteProfileToggleView.loadFromNib()
  private let informationView = AthleteProfileInformationView.loadFromNib()
	
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
    configureDetailView()
    presenter.requestProfile()
	}
  
  // MARK: Private
  
  private func configureToggleView() {
    toggleContainerView.addSubview(toggleView)
    toggleView.translatesAutoresizingMaskIntoConstraints = false
    toggleView.delegate = self
    
    NSLayoutConstraint.activate([
      toggleView.topAnchor.constraint(equalTo: toggleContainerView.topAnchor),
      toggleView.bottomAnchor.constraint(equalTo: toggleContainerView.bottomAnchor),
      toggleView.leadingAnchor.constraint(equalTo: toggleContainerView.leadingAnchor),
      toggleView.trailingAnchor.constraint(equalTo: toggleContainerView.trailingAnchor)
      ])
  }
  
  private func configureDetailView() {
    [informationView].forEach { (view) in //TODO add PB view
      detailContainerView.addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: detailContainerView.topAnchor),
        view.bottomAnchor.constraint(equalTo: detailContainerView.bottomAnchor),
        view.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor)
        ])
    }
  }
  
}

// MARK: AthleteProfilePresenterView

extension AthleteProfileViewController: AthleteProfilePresenterView {
	
  func updateWith(athleteProfile: AthleteProfile) {
    title = athleteProfile.name
    informationView.update(with: athleteProfile)
  }
}

// MARK: AthleteProfiletoggleViewDelegate

extension AthleteProfileViewController: AthleteProfileToggleViewDelegate {
  
  func athleteProfileToggleViewDidTapLeftToggle(_ athleteProfileToggleView: AthleteProfileToggleView) {
    informationView.isHidden = false
  }
  
  func athleteProfileToggleViewDidTapRightToggle(_ athleteProfileToggleView: AthleteProfileToggleView) {
    informationView.isHidden = true
  }
}
