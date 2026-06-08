//
//  CreateAccountRepository.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol AccountRepository {
    func createAccount(account: Account) throws
    func updateAccount(account: Account) throws
    func fetchAccounts(completion: (Result<[Account], Error>) -> Void) throws
    func deleteAccount(id: UUID) throws
}
