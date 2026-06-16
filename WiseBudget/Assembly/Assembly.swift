//
//  Assembly.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

class Assembly {
    
    static let shared = Assembly()
    
    // Data Sources
    lazy var accountManager = AccountManager()
    lazy var categoryManager = CategoryManager()
    lazy var transactionManager = TransactionManager()
    
    // Repositories
    lazy var accountRepository = AccountRepositoryImpl(dataSource: accountManager)

    lazy var categoryRepository = CategoryRepositoryImpl(dataSource: categoryManager)

    lazy var transactionRepository = TransactionRepositoryImpl(dataSource: transactionManager)
    
    // Use Cases

    // Account
    lazy var createAccountUseCase = CreateAccountUseCaseImpl(repository: accountRepository)
    lazy var updateAccountUseCase = UpdateAccountUseCaseImpl(repository: accountRepository)
    lazy var fetchAccountsUseCase = FetchAccountsUseCaseImpl(repository: accountRepository)
    lazy var deleteAccountUseCase = DeleteAccountUseCaseImpl(repository: accountRepository)
    
    // Category
    lazy var createCategoryUseCase = CreateCategoryUseCaseImpl(repository: categoryRepository)
    lazy var updateCategoryUseCase = UpdateCategoryUseCaseImpl(repository: categoryRepository)
    lazy var fetchCategoriesUseCase = FetchCategoriesUseCaseImpl(repository: categoryRepository)
    lazy var deleteCategoryUsecase = DeleteCategoryUseCaseImpl(repository: categoryRepository)

    // Transaction
    lazy var createTransactionUseCase = CreateTransactionUseCaseImpl(repository: transactionRepository)
    lazy var updateTransactionUseCase = UpdateTransactionUseCaseImpl(repository: transactionRepository)
    lazy var fetchTransactionsUseCase = FetchTransactionsUseCaseImpl(repository: transactionRepository)
    lazy var deleteTransactionUseCase = DeleteTransactionUseCaseImpl(repository: transactionRepository)
    
}

extension Assembly {

    func createAccountsViewModel() -> AccountsViewModel {
        AccountsViewModel(
            fetchAccountsUseCase: fetchAccountsUseCase
        )
    }

    func createAccountFormViewModel() -> AccountFormViewModel {
        AccountFormViewModel(
            createAccountUseCase: createAccountUseCase,
            updateAccountUseCase: updateAccountUseCase,
            deleteAccountUseCase: deleteAccountUseCase
        )
    }

    func createHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            fetchTransactionsUseCase: fetchTransactionsUseCase,
            fetchCategoriesUseCase: fetchCategoriesUseCase
        )
    }

    func createTransactionFormViewModel() -> TransactionFormViewModel {
        TransactionFormViewModel(
            createTranscationUseCase: createTransactionUseCase,
            updateTransactionUseCase: updateTransactionUseCase,
            deleteTransactionUseCase: deleteTransactionUseCase,
            accountUpdateUseCase: updateAccountUseCase
        )
    }
    
    func createCategoriesFormViewModel() -> CategoriesFormViewModel {
        CategoriesFormViewModel()
    }
}
