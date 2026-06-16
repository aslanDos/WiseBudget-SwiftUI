//
//  CategoryRepository.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol CategoryRepository {
    func createCategory(category: Category) throws
    func updateCategory(category: Category) throws
    func fetchCategories(completion: (Result<[Category], Error>) -> Void) throws
    func deleteCategory(id: UUID) throws
}
