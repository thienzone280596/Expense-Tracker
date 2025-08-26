//
//  CategoryService.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import CoreData

class CategoryService {
  private let context = PersistenceController.shared.context

  // Add Category
    func addCategory(name: String, type: String, image: String?) {
        let category = Category(context: context)
        category.id = UUID()
        category.name = name
        category.type = type
        category.image = image
        category.createdAt = Date()
        save()
    }

    // get all Category
    func getAllCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch categories failed: \(error)")
            return []
        }
    }

   // get category by type
    func getCategories(byType type: String) -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "type == %@", type)
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch categories failed: \(error)")
            return []
        }
    }

    // Delete Category
    func deleteCategory(_ category: Category) {
        context.delete(category)
        save()
    }

  private func save() {
         do {
             try context.save()
         } catch {
             print("Save category error: \(error)")
         }
     }
}
