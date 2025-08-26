//
//  Expense+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by ThienTran on 26/8/25.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var userID: UUID?
    @NSManaged public var image: String?

}

extension Expense : Identifiable {

}
