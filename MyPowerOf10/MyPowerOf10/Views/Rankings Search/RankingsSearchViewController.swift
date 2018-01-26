//
//  RankingsSearchViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol RankingsSearchViewControllerDelegate: class {
  func rankingsSearchViewController(_ controller: RankingsSearchViewController, didReceiveRankings rankings: [Ranking], fromRequest request: RankingSearchRequest)
}

/// Handles the user interface for the Rankings Search functionality
final class RankingsSearchViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var yearPickerContainerView: UIView!
  @IBOutlet private var regionPickerContainerView: UIView!
  @IBOutlet private var ageGroupPickerContainerView: UIView!
  @IBOutlet private var eventsPickerContainerView: UIView!
  @IBOutlet private var genderSegmentControl: UISegmentedControl!
  @IBOutlet private var searchActionButton: RoundedCornerActionButton!
  @IBOutlet private var errorView: CollapsableErrorView!
  @IBOutlet private var scrollView: UIScrollView!
  
  @IBOutlet private var yearPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var regionPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var ageGroupPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var eventsPickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var errorViewHeightConstraint: NSLayoutConstraint!
	
	// MARK: Internal
	
	weak var delegate: RankingsSearchViewControllerDelegate?
	
	// MARK: Private
	
	private let presenter: RankingsSearchPresenter
  private let yearPicker = DropdownPickerView.loadFromNib()
  private let regionPicker = DropdownPickerView.loadFromNib()
  private let ageGroupPicker = DropdownPickerView.loadFromNib()
  private let eventsPicker = DropdownPickerView.loadFromNib()
  
  private let collapsedHeight: CGFloat = 44
  private let expandedHeight: CGFloat = 144
  
  private typealias PickerPair = (picker: DropdownPickerView, associatedConstraint: NSLayoutConstraint)
  private var pickerPairs: [PickerPair] = []
	
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
    removeBackButtonTitle()
    addLogoItemToNavigationBar()
		presenter.view = self
    presenter.fetchRankingQueryItems()
    setupPickerControl(picker: yearPicker, containerView: yearPickerContainerView, constraint: yearPickerHeightConstraint)
    setupPickerControl(picker: regionPicker, containerView: regionPickerContainerView, constraint: regionPickerHeightConstraint)
    setupPickerControl(picker: ageGroupPicker, containerView: ageGroupPickerContainerView, constraint: ageGroupPickerHeightConstraint)
    setupPickerControl(picker: eventsPicker, containerView: eventsPickerContainerView, constraint: eventsPickerHeightConstraint)
    genderSegmentControl.tintColor = .potRed
    genderSegmentControl.applyShadow()
    setupScrollView()
    view.bringSubview(toFront: errorView)
	}
  
  // MARK: - Private functions
  
  private func setupPickerControl(picker: DropdownPickerView, containerView: UIView, constraint: NSLayoutConstraint) {
    containerView.addSubview(picker)
    picker.pin(toView: containerView)
    containerView.applyShadow()
    let pickerPair: PickerPair = (picker, constraint)
    pickerPairs.append(pickerPair)
  }
  
  private func setupScrollView() {
    if #available(iOS 11.0, *) {
      scrollView.contentInsetAdjustmentBehavior = .never
    }
  }
  
  // MARK: IBActions
  
  @IBAction private func genderDidChange(_ sender: UISegmentedControl) {
    pickerPairs.forEach { pickerPair in
      pickerPair.picker.updatedSelectedState(selected: false, completion: {
        pickerPair.associatedConstraint.constant = self.collapsedHeight
        UIView.reallyShortAnimation(animations: {
          self.view.layoutIfNeeded()
        })
      })
    }
    let genderString = sender.selectedSegmentIndex == 0 ? "Male" : "Female"
    guard let gender = Gender(rawValue: genderString) else { return }
    presenter.selectedGender = gender
  }
  
  @IBAction private func didTapSearch() {
    presenter.requestRanking()
    updateErrorState(isVisible: false)
  }
  
  // MARK: Scroll view adjusting
  
  private func animateScrollView(by offset: CGFloat) {
    UIView.shortAnimation(animations: {
      self.scrollView.contentOffset.y = offset
    })
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
  
  func presenterDidRecieveEvents(events: [RankingQueryItem]) {
    eventsPicker.configure(withItems: events, placeholder: "Event", delegate: self)
  }
  
  func updateSearchButton(isEnabled: Bool) {
    searchActionButton.isEnabled = isEnabled
  }
  
  func updateLoadingState(isLoading: Bool) {
    searchActionButton.isLoading = isLoading
    UIView.shortAnimation(animations: {
      self.contentView.alpha = isLoading ? 0.3 : 1.0
    })
  }
  
  func updateErrorState(isVisible: Bool) {
    let constraintConstant: CGFloat = isVisible ? 48 : 0
    errorViewHeightConstraint.constant = constraintConstant
    UIView.shortAnimation(animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func didRecieveRankings(rankings: [Ranking], request: RankingSearchRequest) {
    delegate?.rankingsSearchViewController(self, didReceiveRankings: rankings, fromRequest: request)
  }
}

// MARK: DropdownPickerViewDelegate

extension RankingsSearchViewController: DropdownPickerViewDelegate {
  
  func dropdownPickerView(_ dropdownPickerView: DropdownPickerView, didChangeSelectRankingQueryItem rankingQueryItem: RankingQueryItem) {
    switch dropdownPickerView {
    case ageGroupPicker: presenter.selectedAgeGroup = rankingQueryItem
    case yearPicker: presenter.selectedYear = rankingQueryItem
    case regionPicker: presenter.selectedRegion = rankingQueryItem
    case eventsPicker: presenter.selectedEvent = rankingQueryItem
    default: return
    }
  }
  
  func dropdownPickerViewDidRequestStateChange(_ dropdownPickerView: DropdownPickerView, selected: Bool) {
    pickerPairs.forEach { pickerPair in
      let isTappedPicker = pickerPair.picker == dropdownPickerView
      let shouldSetSelected = isTappedPicker ? selected : false
      pickerPair.picker.updatedSelectedState(selected: shouldSetSelected, completion: {
        pickerPair.associatedConstraint.constant = shouldSetSelected ? self.expandedHeight : self.collapsedHeight
        UIView.reallyShortAnimation(animations: {
          self.view.layoutIfNeeded()
        })
      })
    }
    
    let offset = (scrollView.contentSize.height + 100) - scrollView.bounds.size.height
    guard dropdownPickerView == eventsPicker,
      offset > 0,
      (scrollView.contentSize.height + 100) > (view.bounds.height - 98),
      selected == true else { return }
    animateScrollView(by: offset) //TODO
  }
}
