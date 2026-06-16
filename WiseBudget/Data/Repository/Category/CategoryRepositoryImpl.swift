//
//  CategoryRepositoryImpl.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

class CategoryRepositoryImpl: CategoryRepository {
    
    private let dataSource: CategoryDataSource
    
    init(dataSource: CategoryDataSource) {
        self.dataSource = dataSource
    }
    
    func createCategory(category: Category) throws {
        try dataSource.createNewCategory(category: category)
    }
    
    func updateCategory(category: Category) throws {
        try dataSource.updateCategory(category: category)
    }
    
    func fetchCategories(completion: (Result<[Category], any Error>) -> Void) throws {
        try dataSource.fetchCategories(completion: completion)
    }
    
    func deleteCategory(id: UUID) throws {
        try dataSource.deleteCategory(id: id)
    }
    
}
