//
//  CreateAccountDataSource.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol AccountDataSource {
    func createNewAccount(account: Account) throws
    func updateAccount(account: Account) throws
    func fetchAccounts(completion: (Result<[Account], Error> ) -> Void) throws
    func deleteAccount(id: UUID) throws
}
