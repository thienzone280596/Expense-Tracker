//
//  Validator.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import Foundation

struct Validator {
    static func validateUsername(_ username: String?) -> String? {
        guard let name = username, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return "Username cannot be empty"
        }
        guard name.count >= 3 else {
            return "Username must be at least 3 characters"
        }
        return nil
    }

    static func validateEmail(_ email: String?) -> String? {
        guard let email = email, !email.isEmpty else {
            return "Email cannot be empty"
        }

        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluate(with: email) else {
            return "Invalid email format"
        }

        return nil
    }

    static func validatePassword(_ password: String?) -> String? {
        guard let pwd = password, !pwd.isEmpty else {
            return "Password cannot be empty"
        }
        guard pwd.count >= 6 else {
            return "Password must be at least 6 characters"
        }
        return nil
    }
}
