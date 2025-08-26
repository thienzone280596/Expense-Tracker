//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by ThienTran on 24/8/25.
//
import Foundation

class CategoryViewModel {
    private let service = CategoryService()
    private(set) var categories: [Category] = []


    func loadCategories() -> [Category] {
        categories = service.getAllCategories()
        return categories
    }

    func filterCategories(keyword: String) -> [Category] {
        guard !keyword.isEmpty else { return categories }
        return categories.filter { $0.name?.localizedCaseInsensitiveContains(keyword) ?? false }
    }
}
