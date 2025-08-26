//
//  CustomTextField.swift
//  ExpenseTracker
//
//  Created by ThienTran on 21/8/25.
//

import UIKit

protocol FloatingPlaceholderTextFieldDelegate: AnyObject {

    func textFieldShouldReturn(_ view: FloatingPlaceholderTextField,
                                 textField: UITextField) -> Bool

    func textFieldDidChange(_ view: FloatingPlaceholderTextField,
                            textField: UITextField)

    func textFieldDidBeginEditing(_ view: FloatingPlaceholderTextField,
                                  textField: UITextField)

    func textFieldDidEndEditing(_ view: FloatingPlaceholderTextField,
                                textField: UITextField)

    func textField(_ view: FloatingPlaceholderTextField,
                   textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool


}

enum FloatingTextViewMode {
    case Normal
    case Editting
    case Erorr
}

class FloatingPlaceholderTextField: UIView {

  @IBOutlet weak var viewMain: UIView!
  @IBOutlet weak var viewTextInput: UIView!
  @IBOutlet weak var textInput: UITextField!
  @IBOutlet weak var lblError: UILabel!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var btnEye: UIButton!

  private var maxLenght: Int = 0
  private var isSecure: Bool = false

  var currentMode: FloatingTextViewMode = .Normal
  weak var delegate: FloatingPlaceholderTextFieldDelegate?
}

extension FloatingPlaceholderTextField {
  //Setup TextField
  func setupTextField(keyboardType: UIKeyboardType = .default,
                      maxLength: Int = 0,
                      isSecurity: Bool = false,
                      placeholder: String,
                      font: UIFont = AppFonts.Afacad.withSize(16),
                      capitalizationType: UITextAutocapitalizationType = .none) {
      self.textInput.keyboardType = keyboardType
      self.lblTitle.text = placeholder
      self.maxLenght = maxLength
      self.textInput.font = font
      self.textInput.placeholder = placeholder
      self.textInput.autocorrectionType = .no
      self.textInput.autocapitalizationType = capitalizationType
      self.viewTextInput.backgroundColor = AppColors.kF5F6F7
      self.viewTextInput.layer.cornerRadius = 20
      self.textInput.delegate = self

      self.isSecure = isSecurity
      self.textInput.isSecureTextEntry = isSecurity
      self.btnEye.setTitle("", for: .normal)
      self.btnEye.isHidden = !isSecurity
      self.lblError.alpha = 0

      if isSecurity {
          self.btnEye.setImage(UIImage(named: "close_eye"), for: .normal)
          self.btnEye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
      }
  }

  @objc private func togglePasswordVisibility() {
      isSecure.toggle()
      textInput.isSecureTextEntry = isSecure

      let imageName = isSecure ? "close_eye" : "eye"
      btnEye.setImage(UIImage(named: imageName), for: .normal)
  }


  //setup nomal
  func setStateNormal() {
    currentMode = .Normal
    lblError.isHidden = true
  }
  //func setupEditing
  func setStateEditting() {
    self.currentMode = .Editting
    UIView.animate(withDuration: 0.3) {
      self.lblError.alpha = 0
      self.layoutIfNeeded()
    }
  }
  //
  func setStateError(_ err: String) {
    self.currentMode = .Erorr
    if textInput.text?.count == 0 {

    }
    self.lblError.text = err
    UIView.animate(withDuration: 0.3) {
      self.lblError.alpha = 1.0
      self.layoutIfNeeded()
    }
  }

  func showError(message: String) {
         setStateError(message)
         viewTextInput.layer.borderColor = UIColor.red.cgColor
         viewTextInput.layer.borderWidth = 1
     }

     func clearError() {
         viewTextInput.layer.borderColor = UIColor.clear.cgColor
         viewTextInput.layer.borderWidth = 0
         lblError.text = ""
         lblError.alpha = 0
     }

  func getValue() -> String {
      return textInput.text ?? ""
  }

  func setValue(value: String) {
      textInput.text  = value
      if value == "" {
          setStateNormal()
      } else {
          setStateEditting()
      }
  }
}

extension FloatingPlaceholderTextField: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      return self.delegate?.textFieldShouldReturn(self, textField: textField) ?? true
  }

  func textFieldDidChangeSelection(_ textField: UITextField) {
      if let d = self.delegate {
          d.textFieldDidChange(self, textField: textField)
      }
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
     // setStateEditting()
      if let d = self.delegate {
          d.textFieldDidBeginEditing(self, textField: textField)
      }
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
      if textField.text?.count == 0 {
          self.setStateNormal()
      }
      if let d = self.delegate {
          d.textFieldDidEndEditing(self, textField: textField)
      }
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if currentMode == .Erorr {
         // setStateEditting()
      }
      currentMode = .Editting

      if let d = self.delegate {
          return d.textField(self, textField: textField, shouldChangeCharactersIn: range, replacementString: string)
      }
      return true
  }
}



