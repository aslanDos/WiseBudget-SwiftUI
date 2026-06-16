//
//  FetchCategoriesUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

protocol FetchCategoriesUseCase: AnyObject {
    func execute(completion: (Result<[Category], Error>) -> Void) throws
}

class FetchCategoriesUseCaseImpl: FetchCategoriesUseCase {
        
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute(completion: (Result<[Category], any Error>) -> Void) throws {
        try repository.fetchCategories(completion: completion)
    }

}
