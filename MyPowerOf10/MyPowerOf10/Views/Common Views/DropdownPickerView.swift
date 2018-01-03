//
//  DropdownPickerView.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 09/12/2017.
//Copyright © 2017 JohnSanderson. All rights reserved.
//

import UIKit

protocol DropdownPickerViewDelegate: class {
  func dropdownPickerViewDidRequestStateChange(_ dropdownPickerView: DropdownPickerView, selected: Bool)
  func dropdownPickerView(_ dropdownPickerView: DropdownPickerView, didChangeSelectRankingQueryItem rankingQueryItem: RankingQueryItem)
}

final class DropdownPickerView: UIView {
  
  // MARK: - Public properties
  
  var isSelected: Bool = false
  
  // MARK: - Private properties
  
  private var items: [RankingQueryItem] = []
  private var placeholder: String = ""
  private weak var delegate: DropdownPickerViewDelegate?
  
  // MARK: - Outlets
  
  @IBOutlet private var dropdownButton: UIButton!
  @IBOutlet private var separatorView: UIView!
  @IBOutlet private var pickerView: UIPickerView!
  @IBOutlet private var separatorHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Override functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  // MARK: - Private functions
  
  private func setup() {
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
  
  func configure(withItems items: [RankingQueryItem], placeholder: String, delegate: DropdownPickerViewDelegate) {
    self.items = items
    self.delegate = delegate
    self.placeholder = placeholder
    let selectedItem = items.first?.displayName ?? ""
    configureButtonTitle(selectedItem: selectedItem)
  }
  
  func updatedSelectedState(selected: Bool, completion: (() -> ())? = nil) {
    isSelected = selected
    separatorHeightConstraint.constant = selected ? AppTheme.mediumBorderWidth : AppTheme.thinBorderWidth
    separatorView.backgroundColor = selected ? .potRed : .potLightGray
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
