//
//  AthleteSearchViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model
import Po10UI

protocol AthleteSearchViewControllerDelegate: class {
  func athleteSearchViewController(_ controller: AthleteSearchViewController, didReceiveAthleteSearchResults athleteResults: [AthleteResult])
}

/// Handles the user interface for the Athlete Search functionality
final class AthleteSearchViewController: UIViewController, KeyboardAdjustableViewController {
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchViewControllerDelegate?
  
  // MARK: Private
  
  private let presenter: AthleteSearchViewPresenter
  private let textFieldCharacterLimit = 30
  private var accessoryView = ActionButtonInputAccessoryView.loadFromNib()
  
  @IBOutlet private var scrollView: UIScrollView!
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var athleteSurnameTextField: SearchTextField!
  @IBOutlet private var athleteFirstNameTextField: SearchTextField!
  @IBOutlet private var athleteClubTextField: SearchTextField!
  @IBOutlet private var errorViewHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Initialiers -
  
  init(delegate: AthleteSearchViewControllerDelegate, presenter: AthleteSearchViewPresenter) {
    self.presenter = presenter
    self.delegate = delegate
    super.init(nibName: String(describing: AthleteSearchViewController.self), bundle: .main)
    observeKeyboardHeightChange(with: #selector(keyboardFrameWillChange))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.view = self
    title = "Athlete Search"
    removeBackButtonTitle()
    addLogoItemToNavigationBar()
    configureTextFields()
    setupAccessoryView()
    setupScrollView()
    setupGestureRecogniser()
  }
  
  // MARK: - Private function
  
  private func configureTextFields() {
    athleteSurnameTextField.update(withPlaceholder: "Surname", delegate: self)
    athleteFirstNameTextField.update(withPlaceholder: "First Name", delegate: self)
    athleteClubTextField.update(withPlaceholder: "Club", delegate: self)
  }
  
  private func setupAccessoryView() {
    accessoryView.update(actionButtonTitle: "Search", delegate: self)
    accessoryView.updateStateOfActionButton(isEnabled: false)
    athleteSurnameTextField.inputAccessoryView = accessoryView
    athleteFirstNameTextField.inputAccessoryView = accessoryView
    athleteClubTextField.inputAccessoryView = accessoryView
  }
  
  private func setupScrollView() {
    if #available(iOS 11.0, *) {
      scrollView.contentInsetAdjustmentBehavior = .never
    }
  }
  
  private func updatePresenter(withValue value: String, forTextField textField: UITextField) {
    if textField == athleteSurnameTextField {
      presenter.athleteSurnameDidChange(to: value)
    } else if textField == athleteFirstNameTextField {
      presenter.athleteFirstNameDidChange(to: value)
    } else {
      presenter.athleteClubDidChange(to: value)
    }
  }
  
  private func setupGestureRecogniser() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponders))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func resignFirstResponders() {
    [athleteSurnameTextField, athleteFirstNameTextField, athleteClubTextField].forEach {
      $0?.resignFirstResponder()
    }
  }
  
  // MARK: Keyboard adjusting
  
  @objc private func keyboardFrameWillChange(_ notification: Notification) {
    let height = keyboardHeight(for: notification)
    scrollView.contentInset.bottom = height
  }
  
  // MARK: Scroll view adjusting
  
  private func animateScrollView(by offset: CGFloat) {
    UIView.shortAnimation(animations: {
      self.scrollView.contentOffset.y = offset
    })
  }
  
}

// MARK: - AthleteSearchPresenterView

extension AthleteSearchViewController: AthleteSearchPresenterView {
  
  func updateLoadingState(isLoading: Bool) {
    accessoryView.isLoading = isLoading
    UIView.shortAnimation(animations: {
      self.contentView.alpha = isLoading ? 0.3 : 1.0
    })
  }
  
  func updateErrorState(isVisible: Bool) {
    let constraintConstant: CGFloat = isVisible ? AppTheme.errorViewPresentedHeight : 0
    errorViewHeightConstraint.constant = constraintConstant
    UIView.shortAnimation(animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func updateSearchButton(isEnabled: Bool) {
    accessoryView.updateStateOfActionButton(isEnabled: isEnabled)
  }
  
  func didRecieveResults(athletes: [AthleteResult]) {
    delegate?.athleteSearchViewController(self, didReceiveAthleteSearchResults: athletes)
  }
  
}

// MARK: - UITextFieldDelegate

extension AthleteSearchViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text as NSString? else { return true }
    let resultingText = text.replacingCharacters(in: range, with: string)
    if resultingText.count <= textFieldCharacterLimit {
      updatePresenter(withValue: resultingText, forTextField: textField)
      return true
    }
    return false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
    textField.layoutIfNeeded()
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    let offset = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height + errorViewHeightConstraint.constant
    guard textField == athleteFirstNameTextField,
      offset > 0 else { return }
    animateScrollView(by: offset)
  }
}

// MARK: - ActionButtonInputAccessoryViewDelegate

extension AthleteSearchViewController: ActionButtonInputAccessoryViewDelegate {
  
  func actionButtonInputAccessoryDidTapActionButton(_ actionButtonInputAccessoryView: ActionButtonInputAccessoryView) {
    presenter.performSearch()
    updateErrorState(isVisible: false)
  }
}
