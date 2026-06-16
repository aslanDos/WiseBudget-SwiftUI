//
//  TransactionRepositoryImpl.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation

class TransactionRepositoryImpl: TransactionRepository {
    
    private let dataSource: TransactionDataSource
    
    init(dataSource: TransactionDataSource) {
        self.dataSource = dataSource
    }
    
    func createTransaction(transaction: Transaction) throws {
        try dataSource.createNewTransaction(transaction: transaction)
    }
    
    func updateTransaction(transaction: Transaction) throws {
        try dataSource.updateTransaction(transaction: transaction)
    }
    
    func fetchTransactions(accountId: UUID?, startDate: Date, endDate: Date, completion: (Result<[Transaction], any Error>) -> Void) throws {
        try dataSource.fetchTransactions(accountId: accountId, startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func deleteTransaction(id: UUID) throws {
        try dataSource.deleteTransaction(id: id)
    }
}
