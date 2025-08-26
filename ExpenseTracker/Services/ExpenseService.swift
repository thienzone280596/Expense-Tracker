//
//  ExpenseService.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//
import Foundation
import CoreData

class ExpenseService {
    private let context = PersistenceController.shared.context

    // MARK: - Create
    func addExpense(title: String,
                    amount: Double,
                    date: Date,
                    category: String,
                    image:String,
                    type: String, // "income" hoặc "expense"
                    location: String? = nil,
                    notes: String? = nil,
                    userID: UUID) -> Bool {
        let expense = Expense(context: context)
        expense.id = UUID()
        expense.title = title
        expense.amount = amount
        expense.date = date
        expense.category = category
        expense.image = image
        expense.type = type
        expense.location = location
        expense.notes = notes
        expense.userID = userID

        return saveContext()
    }

    // MARK: - Fetch
    func fetchExpenses(userID: UUID) -> [Expense] {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "userID == %@", userID as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch Expense error: \(error)")
            return []
        }
    }

    // MARK: - Update
    func updateExpense(expense: Expense,
                       title: String,
                       amount: Double,
                       date: Date,
                       category: String,
                       image: String,
                       type: String,
                       location: String?,
                       notes: String?) -> Bool {
        expense.title = title
        expense.amount = amount
        expense.date = date
        expense.category = category
        expense.image = image
        expense.type = type
        expense.location = location
        expense.notes = notes
        return saveContext()
    }

    // MARK: - Delete
    func deleteExpense(expense: Expense) -> Bool {
        context.delete(expense)
        return saveContext()
    }

    // MARK: - Save helper
    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print("❌ Save error: \(error)")
            return false
        }
    }
}
