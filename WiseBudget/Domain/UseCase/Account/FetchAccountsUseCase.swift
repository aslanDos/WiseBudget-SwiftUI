//
//  FetchAccountsUseCase.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

protocol FetchAccountsUseCase: AnyObject {
    func execute(completion: (Result<[Account], Error>) -> Void) throws
}

class FetchAccountsUseCaseImpl: FetchAccountsUseCase {
        
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func execute(completion: (Result<[Account], any Error>) -> Void) throws {
        try repository.fetchAccounts(completion: completion)
    }

}
