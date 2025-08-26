//
//  LoginViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 20/8/25.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubTitle: UILabel!
  @IBOutlet weak var usernameInputview: UIView!
  @IBOutlet weak var passwordInputView: UIView!
  @IBOutlet weak var btnSignin: ButtonView!
  @IBOutlet weak var lblSignup: UILabel!
  @IBOutlet weak var btnSignup: UIButton!

  lazy var usernameTextField: FloatingPlaceholderTextField = {
      let v = FloatingPlaceholderTextField.instantiate()
      v.translatesAutoresizingMaskIntoConstraints = false
      v.setupTextField(keyboardType: .default, placeholder: "Username", capitalizationType: .none)
      v.tag = 0
      return v
  }()

  lazy var passwordTextField: FloatingPlaceholderTextField = {
    let v = FloatingPlaceholderTextField.instantiate()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.setupTextField(keyboardType: .default, isSecurity: true, placeholder: "Password", capitalizationType: .none)
    v.tag = 1
    return v
  }()

  let viewModel = AuthViewModel()
  var isValidateUsernamePass = false
  var isValidatePasswordPass = false

   // MARK: - life cycle
  override func viewDidLoad() {
        super.viewDidLoad()
    self.setupUI()
    self.setupDelegate()
    self.hideKeyboardWhenTappedAround()

    }

  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      clearData()
  }


  private func setupUI() {
    lblTitle.font = AppFonts.Afacad_Bold.withSize(24)
    lblTitle.textColor = .black
    lblSubTitle.font = AppFonts.Afacad.withSize(16)
    lblSubTitle.textColor = .black

    btnSignin.setText(str: "Sign In", isEnable: false)

    self.usernameInputview.addSubview(usernameTextField)
    self.passwordInputView.addSubview(passwordTextField)
    self.lblSignup.font = AppFonts.Afacad.withSize(14)

    self.btnSignup.setTitle("Sign Up", for: .normal)
    self.btnSignup.titleLabel?.textColor = AppColors.k0066D8
    self.btnSignup.titleLabel?.font = AppFonts.Afacad_Medium.withSize(14)
    self.navigationController?.isNavigationBarHidden = true

    NSLayoutConstraint.activate([
        self.usernameTextField.leadingAnchor.constraint(equalTo: self.usernameInputview.leadingAnchor, constant: 28),
        self.usernameTextField.trailingAnchor.constraint(equalTo: self.usernameInputview.trailingAnchor, constant: -28),
        self.usernameTextField.topAnchor.constraint(equalTo: self.usernameInputview.topAnchor, constant: 0),
        self.usernameTextField.bottomAnchor.constraint(equalTo: self.usernameInputview.bottomAnchor, constant: 0),

        self.passwordTextField.leadingAnchor.constraint(equalTo: self.passwordInputView.leadingAnchor, constant: 28),
        self.passwordTextField.trailingAnchor.constraint(equalTo: self.passwordInputView.trailingAnchor, constant: -28),
        self.passwordTextField.topAnchor.constraint(equalTo: self.passwordInputView.topAnchor, constant: 0),
        self.passwordTextField.bottomAnchor.constraint(equalTo: self.passwordInputView.bottomAnchor, constant: 0),
    ])
  }

  private func setupDelegate() {
    self.usernameTextField.delegate = self
    self.passwordTextField.delegate = self
    self.btnSignin.delegate = self
  }

  func clearData() {
    usernameTextField.setValue(value: "")
    passwordTextField.setValue(value: "")
      btnSignin.disableButton()
  }

  @IBAction func actionSignUp(_ sender: Any) {
    clearData()
    let signupVC = RegisterViewController()
    navigationController?.pushViewController(signupVC, animated: true)
  }
}

extension LoginViewController {
  ///check Login
  func checkLogin() {
    let username = usernameTextField.getValue()
    let password = passwordTextField.getValue()
    if let user = viewModel.login(username: username, password: password) {
              // Lưu session
      SessionManager.shared.signIn(userID: user.id ?? UUID())

              let mainVC = MainTabBarController()
              navigationController?.setViewControllers([mainVC], animated: true)
          } else {

              passwordTextField.setStateError("Tên đăng nhập hoặc mật khẩu không đúng")
          }
  }


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
      case 1: // Password
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
      if isValidateUsernamePass && isValidatePasswordPass {
          btnSignin.enableButton()
      } else {
        btnSignin.disableButton()
      }
  }
}


extension LoginViewController: ButtonViewDelegate {
  func onTapButton(sender: UIView) {
    checkLogin()
  }
}

extension LoginViewController: FloatingPlaceholderTextFieldDelegate {
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

