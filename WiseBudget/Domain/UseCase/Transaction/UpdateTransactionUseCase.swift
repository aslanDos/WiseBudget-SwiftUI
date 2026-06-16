//
//  UpdateTransactionUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 18.06.2026.
//

import Foundation

protocol UpdateTransactionUseCase: AnyObject {
    func execute(transaction: Transaction) throws
}

class UpdateTransactionUseCaseImpl: UpdateTransactionUseCase {
    
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(transaction: Transaction) throws {
        try repository.updateTransaction(transaction: transaction)
    }
}
