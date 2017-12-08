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
  @IBOutlet private var athleteInformationScrollView: UIView!
  @IBOutlet private var athleteInformationContainerView: UIView!
  @IBOutlet private var bestPerformancesContainerView: UIView!
	
	// MARK: Internal
	
	weak var delegate: AthleteProfileViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: AthleteProfilePresenter
  private let toggleView = AthleteProfileToggleView.loadFromNib()
  private let informationView = AthleteProfileInformationView.loadFromNib()
  private let bestPerformancesView = AthleteProfileBestPerformancesView.loadFromNib()
  
  private var isFavourited: Bool = false
	
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
    configureAthleteInformationView()
    configureBestPerformancesView()
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
  
  private func configureAthleteInformationView() {
    athleteInformationContainerView.addSubview(informationView)
    informationView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([ //TODO Pin helper
      informationView.topAnchor.constraint(equalTo: athleteInformationContainerView.topAnchor),
      informationView.bottomAnchor.constraint(equalTo: athleteInformationContainerView.bottomAnchor),
      informationView.leadingAnchor.constraint(equalTo: athleteInformationContainerView.leadingAnchor),
      informationView.trailingAnchor.constraint(equalTo: athleteInformationContainerView.trailingAnchor)
      ])
  }
  
  private func configureBestPerformancesView() {
    bestPerformancesContainerView.addSubview(bestPerformancesView)
    bestPerformancesView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([ //TODO Pin helper
      bestPerformancesContainerView.heightAnchor.constraint(equalToConstant: bestPerformancesView.contentHeight()),
      bestPerformancesView.topAnchor.constraint(equalTo: bestPerformancesContainerView.topAnchor),
      bestPerformancesView.bottomAnchor.constraint(equalTo: bestPerformancesContainerView.bottomAnchor),
      bestPerformancesView.leadingAnchor.constraint(equalTo: bestPerformancesContainerView.leadingAnchor),
      bestPerformancesView.trailingAnchor.constraint(equalTo: bestPerformancesContainerView.trailingAnchor)
      ])
    bestPerformancesContainerView.isHidden = true
  }
  
  private func configureNavigationBar() {
    let favouriteIconName = isFavourited ? "starIconFilled" : "starIcon"
    let favouritedImage = UIImage(named: favouriteIconName)
    let favouritedBarButtonIcon = UIBarButtonItem(image: favouritedImage, style: .plain, target: self, action: #selector(didTapFavouriteAthlete))
    navigationItem.rightBarButtonItem = favouritedBarButtonIcon
  }
  
  @objc private func didTapFavouriteAthlete() {
    isFavourited = !isFavourited
    configureNavigationBar()
    if isFavourited {
      presenter.favouriteAthlete()
    } else {
      presenter.unfavouriteAthlete()
    }
  }
  
}

// MARK: AthleteProfilePresenterView

extension AthleteProfileViewController: AthleteProfilePresenterView {
	
  func updateWith(athleteProfile: AthleteProfile, isFavourited: Bool) {
    title = athleteProfile.name
    self.isFavourited = isFavourited
    informationView.update(with: athleteProfile)
    bestPerformancesView.update(with: athleteProfile.bestPerformances)
    configureNavigationBar()
  }
}

// MARK: AthleteProfiletoggleViewDelegate

extension AthleteProfileViewController: AthleteProfileToggleViewDelegate {
  
  func athleteProfileToggleViewDidTapLeftToggle(_ athleteProfileToggleView: AthleteProfileToggleView) {
    athleteInformationScrollView.isHidden = false
    bestPerformancesContainerView.isHidden = true
  }
  
  func athleteProfileToggleViewDidTapRightToggle(_ athleteProfileToggleView: AthleteProfileToggleView) {
    bestPerformancesContainerView.isHidden = false
    athleteInformationScrollView.isHidden = true
  }
}
