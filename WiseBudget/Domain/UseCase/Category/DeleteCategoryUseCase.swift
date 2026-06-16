//
//  DeleteCategoryUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol DeleteCategoryUseCase: AnyObject {
    func execute(id: UUID) throws
}

class DeleteCategoryUseCaseImpl: DeleteAccountUseCase {
    
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) throws {
        try repository.deleteCategory(id: id)
    }
}
