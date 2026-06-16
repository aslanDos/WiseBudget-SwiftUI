//
//  CreateTransactionUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation

protocol CreateTransactionUseCase: AnyObject {
    func execute(transaction: Transaction) throws
}

class CreateTransactionUseCaseImpl: CreateTransactionUseCase {
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(transaction: Transaction) throws {
        try repository.createTransaction(transaction: transaction)
    }
}
