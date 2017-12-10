//
//  DropdownPickerView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol DropdownPickerViewDelegate: class {
  func dropdownPickerViewDidRequestLayoutOfParent(_ dropdownPickerView: DropdownPickerView)
}

final class DropdownPickerView: UIView {
  
  // MARK: - Public properties
  
  var isSelected: Bool = false {
    didSet {
      updatedSelectedState()
    }
  }
  
  // MARK: - Public properties
  
  private var items: [RankingQueryItem] = []
  private var placeholder: String = ""
  private weak var delegate: DropdownPickerViewDelegate?
  
  // MARK: - Outlets
  
  @IBOutlet private var dropdownButton: UIButton!
  @IBOutlet private var separatorView: UIView!
  @IBOutlet private var pickerView: UIPickerView!
  
  @IBOutlet private var separatorHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var pickerViewZeroHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var pickerViewOpenHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Override functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: - Private functions
  
  private func setup() {
    isSelected = false
    
    configureButton()
    configurePickerView()
  }
  
  private func configureButton() {
    dropdownButton.titleLabel?.font = .systemFont(ofSize: 18)
    dropdownButton.setTitleColor(.potDarkGray, for: .normal)
  }
  
  private func configurePickerView() {
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerView.layer.borderWidth = AppTheme.thinBorderWidth
    pickerView.layer.borderColor = UIColor.potLightGray.cgColor
  }
  
  private func updatedSelectedState() {
    separatorHeightConstraint.constant = isSelected ? AppTheme.mediumBorderWidth : AppTheme.thinBorderWidth
    separatorView.backgroundColor = isSelected ? .potRed : .potLightGray
    
    UIView.reallyShortAnimation(animations: {
      self.pickerView.alpha = self.isSelected ? 1 : 0  //TODO - Sort animation. THis is O.K...
    }, completion: { _ in
      self.pickerViewZeroHeightConstraint.isActive = !self.isSelected
      self.pickerViewOpenHeightConstraint.isActive = self.isSelected
      self.delegate?.dropdownPickerViewDidRequestLayoutOfParent(self)
    })
  }
  
  @IBAction private func didTapDropdownButton() {
    isSelected = !isSelected
  }
  
}

extension DropdownPickerView {
  
  func configure(withItems items: [RankingQueryItem], placeholder: String, delegate: DropdownPickerViewDelegate) {
    self.items = items
    self.delegate = delegate
    self.placeholder = placeholder
    let selectedItem = items.first?.displayName ?? ""
    dropdownButton.setTitle("\(placeholder): \(selectedItem)", for: .normal)
  }
  
}

// MARK: - UIPickerViewDelegate and UIPickerViewDataSource

extension DropdownPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return items.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return items[row].displayName
  }
  
  //TODO figure out custom font
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    dropdownButton.setTitle("\(placeholder): \(items[row].displayName)", for: .normal)
  }
}
