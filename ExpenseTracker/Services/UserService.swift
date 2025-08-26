//
//  UserService.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

//UserService → đăng ký, đăng nhập

import CoreData

class UserService {
  private let context = PersistenceController.shared.context

  // MARK: - Login
  func login(username: String, password: String) -> User? {
      let request: NSFetchRequest<User> = User.fetchRequest()
      request.predicate = NSPredicate(
          format: "username == %@ AND password == %@", username, password
      )
      request.fetchLimit = 1

      do {
          let users = try context.fetch(request)
          return users.first
      } catch {
          print("Login error: \(error)")
          return nil
      }
  }



  func registerUser(userName: String, email:String, password:String) -> Bool {
    let user = User(context: context)
    user.id = UUID()
    user.email = email
    user.password = password
    user.username = userName
    user.createdAt = Date()
    print("User: \(user)")
    save()
    return true
  }

  func isEmailExist(_ email: String) -> Bool {
      let request: NSFetchRequest<User> = User.fetchRequest()
      request.predicate = NSPredicate(format: "email == %@", email)

      do {
          let count = try context.count(for: request)
          return count > 0
      } catch {
          return false
      }
  }

  func findUser(by id: UUID) -> User? {
      let request: NSFetchRequest<User> = User.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
      request.fetchLimit = 1
      do {
          return try context.fetch(request).first
      } catch {
          print("Find user error: \(error)")
          return nil
      }
  }

  //save
  private func save() {
         do {
             try context.save()
         } catch {
             print("Save error: \(error)")
         }
     }
}
