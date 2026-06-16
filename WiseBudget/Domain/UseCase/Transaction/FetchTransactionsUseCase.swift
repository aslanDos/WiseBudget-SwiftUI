//
//  FetchTransactionsUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 18.06.2026.
//

import Foundation

protocol FetchTransactionsUseCase: AnyObject {
    func execute(accountId: UUID?, startDate: Date, endDate: Date, completion: (Result<[Transaction], Error>) -> Void) throws
}

class FetchTransactionsUseCaseImpl: FetchTransactionsUseCase {
    
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(accountId: UUID?, startDate: Date, endDate: Date, completion: (Result<[Transaction], Error>) -> Void) throws {
        try repository.fetchTransactions(accountId: accountId, startDate: startDate, endDate: endDate, completion: completion)
    }
}
