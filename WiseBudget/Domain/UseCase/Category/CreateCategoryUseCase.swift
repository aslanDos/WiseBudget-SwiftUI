//
//  CreateCategoryUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol CreateCategoryUseCase: AnyObject {
    func execute(category: Category) throws
}

class CreateCategoryUseCaseImpl: CreateCategoryUseCase {
    
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute(category: Category) throws {
        try repository.createCategory(category: category)
    }
}
