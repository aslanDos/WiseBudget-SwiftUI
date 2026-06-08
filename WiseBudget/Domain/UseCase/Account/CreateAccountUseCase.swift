//
//  CreateAccountUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol CreateAccountUseCase: AnyObject {
    func execute(account: Account) throws
}

class CreateAccountUseCaseImpl: CreateAccountUseCase {
    
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func execute(account: Account) throws {
        try repository.createAccount(account: account)
    }
}
