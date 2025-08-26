//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//

import Foundation

class ExpenseViewModel {
    private let service = ExpenseService()
    private(set) var expenses: [Expense] = []

    var onExpensesUpdated: (() -> Void)?

   
    func loadExpenses(for userID: UUID) {
        expenses = service.fetchExpenses(userID: userID)
        onExpensesUpdated?()
    }

    // Add Expense
    func addExpense(title: String,
                    amount: Double,
                    date: Date,
                    category: String,
                    image:String = "",
                    type: String,
                    location: String? = nil,
                    notes: String? = nil,
                    userID: UUID) {
        if service.addExpense(title: title,
                              amount: amount,
                              date: date,
                              category: category,
                              image: image,
                              type: type,
                              location: location,
                              notes: notes,
                              userID: userID) {
            loadExpenses(for: userID) // reload list
        }
    }

    // Update
    func updateExpense(_ expense: Expense,
                       title: String,
                       amount: Double,
                       date: Date,
                       category: String,
                       image: String,
                       type: String,
                       location: String?,
                       notes: String?,
                       userID: UUID) {
        if service.updateExpense(expense: expense,
                                 title: title,
                                 amount: amount,
                                 date: date,
                                 category: category, image: image,
                                 type: type,
                                 location: location,
                                 notes: notes) {
            loadExpenses(for: userID)
        }
    }

    // Delete
    func deleteExpense(_ expense: Expense, userID: UUID) {
        if service.deleteExpense(expense: expense) {
            loadExpenses(for: userID)
        }
    }
}
