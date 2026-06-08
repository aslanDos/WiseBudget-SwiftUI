//
//  UpdateAccountUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol UpdateAccountUseCase: AnyObject {
    func execute(account: Account) throws
}

class UpdateAccountUseCaseImpl: UpdateAccountUseCase {
    
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func execute(account: Account) throws {
        try repository.updateAccount(account: account)
    }
}
