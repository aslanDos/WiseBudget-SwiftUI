//
//  CategoryManager.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation
import CoreData

class CategoryManager: CategoryDataSource {
    
    private let context = PersistentContainer.shared.persistentContainer.viewContext
    
    func createNewCategory(category: Category) throws {
        let _ = CategoryMapper.toEntity(from: category, context: context)
        try context.save()
    }
    
    func updateCategory(category: Category) throws {
        //
    }
    
    func fetchCategories(completion: (Result<[Category], any Error>) -> Void) throws {
        let req = CategoryEntity.fetchRequest()
        
        req.sortDescriptors = [
            NSSortDescriptor(key: "order", ascending: true)
        ]
        
        let categories = try context.fetch(req)
        
        let domainCategories = categories.map { item in
            CategoryMapper.toDomain(from: item)
        }
        
        completion(.success(domainCategories))
    }
    
    func deleteCategory(id: UUID) throws {
        //
    }
    
    func createNewAccount(account: Account) throws {
        let _ = AccountMapper.toEntity(from: account, context: context)
        try context.save()
    }
}
