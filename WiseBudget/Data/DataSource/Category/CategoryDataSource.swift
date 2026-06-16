//
//  CategoryDateSource.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol CategoryDataSource {
    func createNewCategory(category: Category) throws
    func updateCategory(category: Category) throws
    func fetchCategories(completion: (Result<[Category], Error> ) -> Void) throws
    func deleteCategory(id: UUID) throws
}
