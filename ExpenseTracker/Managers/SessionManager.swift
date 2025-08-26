//
//  SessionManager.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import Foundation

final class SessionManager {
    static let shared = SessionManager()
    private init() {}

    private let key = "loggedInUserID"

    var currentUserID: UUID? {
        get {
            if let s = UserDefaults.standard.string(forKey: key) {
                return UUID(uuidString: s)
            }
            return nil
        }
        set {
            if let id = newValue {
                UserDefaults.standard.set(id.uuidString, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }

    var isLoggedIn: Bool { currentUserID != nil }

    func signIn(userID: UUID) {
        currentUserID = userID
    }

    func signOut() {
        currentUserID = nil
    }
}
