//
//  RegisterViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 20/8/25.
//

import UIKit

class RegisterViewController: UIViewController {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubtitle: UILabel!

  @IBOutlet weak var usernameView: UIView!
  @IBOutlet weak var emailView: UIView!
  @IBOutlet weak var passwordView: UIView!
  @IBOutlet weak var btnSignup: ButtonView!

  @IBOutlet weak var lblSignin: UILabel!
  @IBOutlet weak var btnSignin: UIButton!

  @IBOutlet weak var bottomConfirmConstraint: NSLayoutConstraint!
  
  lazy var usernameTextField: FloatingPlaceholderTextField = {
    let v = FloatingPlaceholderTextField.instantiate()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.setupTextField(keyboardType: .default, placeholder: "Username", capitalizationType: .none)
    v.tag = 0
    return v
  }()

  lazy var emailTextField: FloatingPlaceholderTextField = {
    let v = FloatingPlaceholderTextField.instantiate()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.setupTextField(keyboardType: .emailAddress, placeholder: "Email", capitalizationType: .none)
    v.tag = 1
    return v
  }()

  lazy var passwordTextField: FloatingPlaceholderTextField = {
    let v = FloatingPlaceholderTextField.instantiate()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.setupTextField(keyboardType: .default, isSecurity: true, placeholder: "password", capitalizationType: .none)
    v.tag = 2
    return v
  }()

  let viewModel = AuthViewModel()
  var isValidateUsernamePass = false
  var isValidateEmailPass = false
  var isValidatePasswordPass = false

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.hideKeyboardWhenTappedAround()
  }

  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      clearData()
  }


  private func setupUI() {
    self.navigationController?.isNavigationBarHidden = true
    lblTitle.font = AppFonts.Afacad_Bold.withSize(24)
    lblTitle.textColor = .black
    lblSubtitle.font = AppFonts.Afacad.withSize(16)
    lblSubtitle.textColor = .black
    btnSignup.setText(str: "Sign up", isEnable: false)

    self.usernameView.addSubview(usernameTextField)
    self.emailView.addSubview(emailTextField)
    self.passwordView.addSubview(passwordTextField)

    self.usernameTextField.delegate = self
    self.emailTextField.delegate = self
    self.passwordTextField.delegate = self

    self.lblSignin.font = AppFonts.Afacad.withSize(14)
    self.btnSignin.setTitle("Sign in", for: .normal)
    self.btnSignin.titleLabel?.textColor = AppColors.k0066D8
    self.btnSignin.titleLabel?.font = AppFonts.Afacad_Medium.withSize(14)

    self.btnSignup.delegate = self


    NSLayoutConstraint.activate([
      self.usernameTextField.leadingAnchor.constraint(equalTo: self.usernameView.leadingAnchor, constant: 28),
      self.usernameTextField.trailingAnchor.constraint(equalTo: self.usernameView.trailingAnchor, constant: -28),
      self.usernameTextField.topAnchor.constraint(equalTo: self.usernameView.topAnchor, constant: 0),
      self.usernameTextField.bottomAnchor.constraint(equalTo: self.usernameView.bottomAnchor, constant: 0),

      self.emailTextField.leadingAnchor.constraint(equalTo: self.emailView.leadingAnchor, constant: 28),
      self.emailTextField.trailingAnchor.constraint(equalTo: self.emailView.trailingAnchor, constant: -28),
      self.emailTextField.topAnchor.constraint(equalTo: self.emailView.topAnchor, constant: 0),
      self.emailTextField.bottomAnchor.constraint(equalTo: self.emailView.bottomAnchor, constant: 0),

      self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordView.leadingAnchor, constant: 28),
      self.passwordTextField.trailingAnchor.constraint(equalTo: self.passwordView.trailingAnchor, constant: -28),
      self.passwordTextField.topAnchor.constraint(equalTo: self.passwordView.topAnchor, constant: 0),
      self.passwordTextField.bottomAnchor.constraint(equalTo: self.passwordView.bottomAnchor, constant: 0),
    ])

          NotificationCenter.default.addObserver(self,
                                                 selector: #selector(keyboardWillShow),
                                                 name: UIResponder.keyboardWillShowNotification,
                                                 object: nil)

          NotificationCenter.default.addObserver(self,
                                                 selector: #selector(keyboardWillHide),
                                                 name: UIResponder.keyboardWillHideNotification,
                                                 object: nil)
  }


    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            print("Keyboard height: \(keyboardFrame.height)")
            self.view.frame.origin.y = -keyboardFrame.height / 2
        }
    }


    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }

  func clearData() {
    self.usernameTextField.setValue(value: "")
    self.emailTextField.setValue(value: "")
    self.passwordTextField.setValue(value: "")
  }

  @IBAction func actionSignin(_ sender: Any) {
    clearData()
    navigationController?.popViewController(animated: true)
  }

}

extension RegisterViewController: FloatingPlaceholderTextFieldDelegate {

  func validateWhenTextFieldChange(viewTag: Int, text: String, isShowErr: Bool) {
      switch viewTag {
      case 0: // Username
          if let err = Validator.validateUsername(text) {
              isValidateUsernamePass = false
              if isShowErr {
                  usernameTextField.setStateError(err)
              }
          } else {
              isValidateUsernamePass = true
              usernameTextField.setStateEditting()
          }
      case 1: // Email
          if let err = Validator.validateEmail(text) {
              isValidateEmailPass = false
              if isShowErr {
                  emailTextField.setStateError(err)
              }
          } else {
              isValidateEmailPass = true
              emailTextField.setStateEditting()
          }
      case 2: // Password
          if let err = Validator.validatePassword(text) {
              isValidatePasswordPass = false
              if isShowErr {
                  passwordTextField.setStateError(err)
              }
          } else {
              isValidatePasswordPass = true
              passwordTextField.setStateEditting()
          }
      default:
          break
      }

      // Enable/disable button
      if isValidateUsernamePass && isValidateEmailPass && isValidatePasswordPass {
          btnSignup.enableButton()
      } else {
          btnSignup.disableButton()
      }
  }


  func textFieldShouldReturn(_ view: FloatingPlaceholderTextField, textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    view.endEditing(true)
    return false
  }

  func textFieldDidChange(_ view: FloatingPlaceholderTextField, textField: UITextField) {
    guard let text = textField.text else {
        return
    }
    self.validateWhenTextFieldChange(viewTag: view.tag, text: text, isShowErr: false)

  }

  func textFieldDidBeginEditing(_ view: FloatingPlaceholderTextField, textField: UITextField) {

  }

  func textFieldDidEndEditing(_ view: FloatingPlaceholderTextField, textField: UITextField) {
    guard let text = textField.text else {
        return
    }

    self.validateWhenTextFieldChange(viewTag: view.tag, text: text, isShowErr: true)
  }

  func textField(_ view: FloatingPlaceholderTextField, textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if view.isFirstResponder {
      if view.textInputMode?.primaryLanguage == nil || view.textInputMode?.primaryLanguage == "emoji" {
        return false;
      }
    }

    return true
  }


}

extension RegisterViewController : ButtonViewDelegate {
  func onTapButton(sender: UIView) {
    checkRegister()
  }

  func checkRegister() {
    let userText = usernameTextField.getValue()
    let emailText = emailTextField.getValue()
    let passwordText = passwordTextField.getValue()
    btnSignup.enableButton()
    let error = viewModel.register(username: userText, email: emailText, password: passwordText)

    if let error = error {
      print("Error \(error)")
    } else {
      navigationController?.popViewController(animated: true)
    }
  }
}
