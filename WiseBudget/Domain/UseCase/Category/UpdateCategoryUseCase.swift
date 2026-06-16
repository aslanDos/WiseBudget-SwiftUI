//
//  UpdateCategoryUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol UpdateCategoryUseCase: AnyObject {
    func execute(category: Category) throws
}

class UpdateCategoryUseCaseImpl: UpdateCategoryUseCase {
    
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute(category: Category) throws {
        try repository.updateCategory(category: category)
    }
}
