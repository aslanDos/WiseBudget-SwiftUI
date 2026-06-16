//
//  TransactionDataSource.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation

protocol TransactionDataSource {
    func createNewTransaction(transaction: Transaction) throws
    func updateTransaction(transaction: Transaction) throws
    func fetchTransactions(accountId: UUID?, startDate: Date, endDate: Date, completion: (Result<[Transaction], Error> ) -> Void) throws
    func deleteTransaction(id: UUID) throws
}
