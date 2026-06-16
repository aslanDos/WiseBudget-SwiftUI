//
//  AppState.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 09.06.2026.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    
    private let fetchAccountsUseCase = Assembly.shared.fetchAccountsUseCase
    private let fetchCategoriesUseCase = Assembly.shared.fetchCategoriesUseCase
    
    @Published var selectedAccount: Account?
    @Published var selectedTransaction: Transaction?
    @Published var showTransactionForm: Bool = false
    @Published var isSplashFinished: Bool = false
    
    var accountsDidChange = PassthroughSubject<Void, Never>()
    var transactionDidChange = PassthroughSubject<Void, Never>()
    
    @Published var categories: [Category] = []
    
    var incomeCategories: [Category] {
        categories.filter { $0.type == .income }
    }

    var expenseCategories: [Category] {
        categories.filter { $0.type == .expense }
    }
    
    @Published var accounts: [Account] = []
    
    func initialize() {
        createDefaultCategoriesIfNeeded()
        loadAccounts()
        loadCategories()
    }
    
    private func createDefaultCategoriesIfNeeded() {
        let isInitialized = UserDefaults.standard.bool(
            forKey: "categories_initialized"
        )

        guard !isInitialized else { return }

        do {
            try InitialDataLoader().loadDefaultCategoriesIfNeeded()
                
            UserDefaults.standard.set(
                true,
                forKey: "categories_initialized"
            )
        } catch {
            print(error)
        }
    }
    
    func category(for id: UUID) -> Category? {
        categories.first { $0.id == id }
    }
    
    private func loadCategories() {
        do {
            try fetchCategoriesUseCase.execute { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.categories = success
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func loadAccounts() {
        do {
            try fetchAccountsUseCase.execute { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.accounts = success
                        if self.selectedAccount == nil {
                            self.selectedAccount = success.first
                        }
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        } catch {
            
        }
    }
}
