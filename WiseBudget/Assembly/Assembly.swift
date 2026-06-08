//
//  Assembly.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

class Assembly {
    
    static func createAccountsViewModel() -> AccountsViewModel {
        let dataSource = AccountManager()
        let repository = AccountRepositoryImpl(dataSource: dataSource)
        let useCase = FetchAccountsUseCaseImpl(repository: repository)
        return AccountsViewModel(fetchAccountsUseCase: useCase)
    }
    
    static func createAccountFormViewModel() -> AccountFormViewModel {
        let dataSource = AccountManager()
        let repository = AccountRepositoryImpl(dataSource: dataSource)
        let useCase = CreateAccountUseCaseImpl(repository: repository)
        return AccountFormViewModel(createAccountUseCase: useCase)
    }
}
