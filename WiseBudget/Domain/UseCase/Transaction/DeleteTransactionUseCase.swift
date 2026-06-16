//
//  DeleteTransactionUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 18.06.2026.
//

import Foundation

protocol DeleteTransactionUseCase: AnyObject {
    func execute(id: UUID) throws
}

class DeleteTransactionUseCaseImpl: DeleteTransactionUseCase {
    
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) throws {
        try repository.deleteTransaction(id: id)
    }
}
