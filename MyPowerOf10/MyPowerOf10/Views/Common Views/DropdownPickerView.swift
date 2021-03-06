//
//  DropdownPickerView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit
import Po10Model
import Po10UI

protocol DropdownPickerViewDelegate: class {
  func dropdownPickerViewDidRequestStateChange(_ dropdownPickerView: DropdownPickerView, selected: Bool)
  func dropdownPickerView(_ dropdownPickerView: DropdownPickerView, didChangeSelectRankingQueryItem rankingQueryItem: RankingSearchRequest.RankingQueryItem)
}

final class DropdownPickerView: UIView {
  
  // MARK: - Public properties
  
  var isSelected: Bool = false
  
  // MARK: - Private properties
  
  private var items: [RankingSearchRequest.RankingQueryItem] = []
  private var placeholder: String = ""
  private weak var delegate: DropdownPickerViewDelegate?
  
  // MARK: - Outlets
  
  @IBOutlet private var dropdownButton: UIButton!
  @IBOutlet private var pickerView: UIPickerView!
  
  // MARK: - Override functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: - Private functions
  
  private func setup() {
    layer.cornerRadius = AppTheme.cornerRadius
    dropdownButton.backgroundColor = .potBackgroundGray
    configurePickerView()
    updatedSelectedState(selected: false)
  }
  
  private func configureButtonTitle(selectedItem: String) {
    let placeholderAttributedString = NSAttributedString(string: "\(placeholder): ", attributes: [.foregroundColor : UIColor.potLightGray])
    let selectedItemAttributedString = NSAttributedString(string: "\(selectedItem)", attributes: [.foregroundColor : UIColor.potDarkGray])
    let mutableAttributedTitle = NSMutableAttributedString(attributedString: placeholderAttributedString)
    mutableAttributedTitle.append(selectedItemAttributedString)
    dropdownButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
  }
  
  private func configurePickerView() {
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerView.layer.borderWidth = AppTheme.thinBorderWidth
    pickerView.layer.borderColor = UIColor.potLightGray.cgColor
  }
  
  @IBAction private func didTapDropdownButton() {
    delegate?.dropdownPickerViewDidRequestStateChange(self, selected: !isSelected)
  }
  
}

extension DropdownPickerView {
  
  func configure(withItems items: [RankingSearchRequest.RankingQueryItem], placeholder: String, delegate: DropdownPickerViewDelegate) {
    self.items = items
    self.delegate = delegate
    self.placeholder = placeholder
    pickerView.selectRow(0, inComponent: 0, animated: false)
    let selectedItem = items.first?.displayName ?? ""
    configureButtonTitle(selectedItem: selectedItem)
    pickerView.reloadAllComponents()
  }
  
  func updatedSelectedState(selected: Bool, completion: (() -> ())? = nil) {
    isSelected = selected
    layer.borderWidth = selected ? AppTheme.mediumBorderWidth : AppTheme.thinBorderWidth
    layer.borderColor = selected ? UIColor.potRed.cgColor : UIColor.potLightGray.cgColor
    UIView.reallyShortAnimation(animations: {
      self.pickerView.alpha = selected ? 1 : 0
    }, completion: { _ in
      completion?()
    })
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
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    configureButtonTitle(selectedItem: items[row].displayName)
    delegate?.dropdownPickerView(self, didChangeSelectRankingQueryItem: items[row])
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let pickerLabel = (view as? UILabel) ?? UILabel()
    let titleString = items[row].displayName
    let title = NSAttributedString(string: titleString, attributes: [.foregroundColor : UIColor.potDarkGray, .font : UIFont.systemFont(ofSize: 20)])
    pickerLabel.attributedText = title
    pickerLabel.textAlignment = .center
    return pickerLabel
    
  }
}
