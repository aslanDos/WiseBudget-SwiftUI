//
//  DeleteAccount.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol DeleteAccountUseCase: AnyObject {
    func execute(id: UUID) throws
}

class DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) throws {
        try repository.deleteAccount(id: id)
    }
}
