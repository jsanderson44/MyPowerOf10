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
  
  @IBOutlet private var yearPickerContainerView: UIView!
  @IBOutlet private var regionPickerContainerView: UIView!
  @IBOutlet private var ageGroupPickerContainerView: UIView!
  
  @IBOutlet private var yearPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var regionPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var ageGroupPickerHeightConstraint: NSLayoutConstraint!
	
	// MARK: Internal
	
	weak var delegate: RankingsSearchViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: RankingsSearchPresenter
  private let yearPicker = DropdownPickerView.loadFromNib()
  private let regionPicker = DropdownPickerView.loadFromNib()
  private let ageGroupPicker = DropdownPickerView.loadFromNib()
  
  private let collapsedHeight: CGFloat = 44
  private let expandedHeight: CGFloat = 164
	
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
    title = "Top 50"
		presenter.view = self
    presenter.fetchRankingQueryItems()
    
    yearPickerContainerView.addSubview(yearPicker)
    yearPicker.pin(toView: yearPickerContainerView)
    
    regionPickerContainerView.addSubview(regionPicker)
    regionPicker.pin(toView: regionPickerContainerView)
    
    ageGroupPickerContainerView.addSubview(ageGroupPicker)
    ageGroupPicker.pin(toView: ageGroupPickerContainerView)
	}
	
}

// MARK: RankingsSearchPresenterView

extension RankingsSearchViewController: RankingsSearchPresenterView {
  func presenterDidReceiveYears(years: [RankingQueryItem]) {
    yearPicker.configure(withItems: years, placeholder: "Year", delegate: self)
  }
  
  func presenterDidReceiveRegions(regions: [RankingQueryItem]) {
    regionPicker.configure(withItems: regions, placeholder: "Region/Nation", delegate: self)
  }
  
  func presenterDidReceiveAgeGroups(ageGroups: [RankingQueryItem]) {
    ageGroupPicker.configure(withItems: ageGroups, placeholder: "Age Group", delegate: self)
  }
}

// MARK: DropdownPickerViewDelegate

extension RankingsSearchViewController: DropdownPickerViewDelegate {
  //TODO REFACTOR!
  func dropdownPickerViewDidToggleSelection(_ dropdownPickerView: DropdownPickerView, isSelected: Bool) {
    switch dropdownPickerView {
    case ageGroupPicker:
      ageGroupPickerHeightConstraint.constant = isSelected ? expandedHeight : collapsedHeight
      yearPickerHeightConstraint.constant = collapsedHeight
      yearPicker.isSelected = false
      regionPickerHeightConstraint.constant = collapsedHeight
      regionPicker.isSelected = false
    case yearPicker:
      yearPickerHeightConstraint.constant = isSelected ? expandedHeight : collapsedHeight
      ageGroupPickerHeightConstraint.constant = collapsedHeight
      ageGroupPicker.isSelected = false
      regionPickerHeightConstraint.constant = collapsedHeight
      regionPicker.isSelected = false
    case regionPicker:
      regionPickerHeightConstraint.constant = isSelected ? expandedHeight : collapsedHeight
      ageGroupPickerHeightConstraint.constant = collapsedHeight
      ageGroupPicker.isSelected = false
      yearPickerHeightConstraint.constant = collapsedHeight
      yearPicker.isSelected = false
    default:
      yearPickerHeightConstraint.constant = collapsedHeight
      yearPicker.isSelected = false
      ageGroupPickerHeightConstraint.constant = collapsedHeight
      ageGroupPicker.isSelected = false
      regionPickerHeightConstraint.constant = collapsedHeight
      regionPicker.isSelected = false
    }
    UIView.reallyShortAnimation(animations: {
      self.view.layoutIfNeeded()
    })
  }
}
