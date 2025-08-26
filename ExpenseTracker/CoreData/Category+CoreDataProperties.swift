//
//  Category+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by ThienTran on 24/8/25.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var userID: UUID?
    @NSManaged public var type: String?
    @NSManaged public var createdAt:Date?

}

extension Category : Identifiable {

}
