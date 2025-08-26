//
//  AuthViewModel.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import Foundation

class AuthViewModel {
  private let service = UserService()

  func login(username: String, password: String) -> User? {
      return service.login(username: username, password: password)
  }

  func register(username: String, email: String, password: String) -> String? {
       // Validate input
       if let error = Validator.validateUsername(username) {
           return error
       }
       if let error = Validator.validateEmail(email) {
           return error
       }
       if let error = Validator.validatePassword(password) {
           return error
       }
    
       if service.isEmailExist(email) {
           return "Email already registered"
       }

       // Gọi Core Data lưu User
       let success = service.registerUser(userName: username, email: email, password: password)
       return success ? nil : "Failed to register user"
   }

  func getCurrentUser() -> User? {
      guard let userID = SessionManager.shared.currentUserID else { return nil }
      return service.findUser(by: userID)
  }

}
