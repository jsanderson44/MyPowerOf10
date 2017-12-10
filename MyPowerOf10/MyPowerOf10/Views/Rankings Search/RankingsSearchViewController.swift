//
//  RankingsSearchViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol RankingsSearchViewControllerDelegate: class {
	// TODO: Add delegate requirements
}

/// Handles the user interface for the Rankings Search functionality
final class RankingsSearchViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet private var ageGroupPickerContainerView: UIView!
  @IBOutlet private var secondDropdownButtonContainerView: UIView!
	
	// MARK: Internal
	
	weak var delegate: RankingsSearchViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: RankingsSearchPresenter
  private let ageGroupPicker = DropdownPickerView.loadFromNib()
  private let secondDropdownPickerView = DropdownPickerView.loadFromNib()
	
	// MARK: - Initialiers -
	
	init(delegate: RankingsSearchViewControllerDelegate, presenter: RankingsSearchPresenter) {
		self.presenter = presenter
		self.delegate = delegate
		super.init(nibName: String(describing: RankingsSearchViewController.self), bundle: Bundle(for: RankingsSearchViewController.self))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.view = self
    presenter.fetchAgeGroups()
    
    ageGroupPickerContainerView.addSubview(ageGroupPicker)
    ageGroupPicker.pin(toView: ageGroupPickerContainerView)
    
    secondDropdownButtonContainerView.addSubview(secondDropdownPickerView)
    secondDropdownPickerView.pin(toView: secondDropdownButtonContainerView)
//    secondDropdownPickerView.configure(withItems: ["2017", "2016"], delegate: self)
	}
	
}

// MARK: RankingsSearchPresenterView

extension RankingsSearchViewController: RankingsSearchPresenterView {
  func presenterDidReceiveAgeGroups(ageGroups: [RankingQueryItem]) {
    ageGroupPicker.configure(withItems: ageGroups, delegate: self)
  }
}

// MARK: DropdownPickerViewDelegate

extension RankingsSearchViewController: DropdownPickerViewDelegate {
  func dropdownPickerViewDidRequestLayoutOfParent(_ dropdownPickerView: DropdownPickerView) {
    UIView.reallyShortAnimation(animations: {
      self.view.layoutIfNeeded()
    })
  }
}
