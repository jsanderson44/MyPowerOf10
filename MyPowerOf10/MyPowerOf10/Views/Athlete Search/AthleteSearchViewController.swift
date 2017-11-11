//
//  AthleteSearchViewController.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 11/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol AthleteSearchViewControllerDelegate: class {
  func athleteSearchViewController(_ controller: AthleteSearchViewController, didReceiveAthleteSearchResults athleteResults: [AthleteResult])
}

/// Handles the user interface for the Athlete Search functionality
final class AthleteSearchViewController: UIViewController {
  
  // MARK: Internal
  
  weak var delegate: AthleteSearchViewControllerDelegate?
  
  // MARK: Private
  
  private let presenter: AthleteSearchViewPresenter
  private let textFieldCharacterLimit = 30
  
  @IBOutlet private var athleteSurnameTextField: UITextField!
  @IBOutlet private var athleteFirstNameTextField: UITextField!
  @IBOutlet private var athleteClubTextField: UITextField!
  
  // MARK: - Initialiers -
  
  init(delegate: AthleteSearchViewControllerDelegate, presenter: AthleteSearchViewPresenter) {
    self.presenter = presenter
    self.delegate = delegate
    super.init(nibName: String(describing: AthleteSearchViewController.self), bundle: .main)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.delegate = self
    title = "Athlete Search"
    athleteSurnameTextField.becomeFirstResponder()
  }
  
  // MARK: - Outlets
  
  @IBAction private func didTapSearch() {
    presenter.performSearch()
  }
  
}

// MARK: - AthleteSearchViewPresenterDelegate

extension AthleteSearchViewController: AthleteSearchViewPresenterDelegate {
  
  func updateLoadingState() {
    // Change loading state
  }
  
  func showError() {
    // Show error
  }
  
  func updateSearchButton(isEnabled: Bool) {
    // Update state of search button
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
  
  private func updatePresenter(withValue value: String, forTextField textField: UITextField) {
    if textField == athleteSurnameTextField {
      presenter.athleteSurnameDidChange(to: value)
    } else if textField == athleteFirstNameTextField {
      presenter.athleteFirstNameDidChange(to: value)
    } else {
      presenter.athleteClubDidChange(to: value)
    }
  }
}
