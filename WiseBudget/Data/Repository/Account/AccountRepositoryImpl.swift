//
//  CreateAccountRepositoryImpl.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

class AccountRepositoryImpl: AccountRepository {
    
    private let dataSource: AccountDataSource
    
    init(dataSource: AccountDataSource) {
        self.dataSource = dataSource
    }
    
    func createAccount(account: Account) throws {
        try dataSource.createNewAccount(account: account)
    }
    
    func updateAccount(account: Account) throws {
        try dataSource.updateAccount(account: account)
    }
    
    func fetchAccounts(completion: (Result<[Account], any Error>) -> Void) throws {
        try dataSource.fetchAccounts(completion: completion)
    }
    
    func deleteAccount(id: UUID) throws {
        try dataSource.deleteAccount(id: id)
    }
}
