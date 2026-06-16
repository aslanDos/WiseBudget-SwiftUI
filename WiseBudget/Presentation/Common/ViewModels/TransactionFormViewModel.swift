//
//  TransactionViewModel.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation
import Combine

class TransactionFormViewModel: ObservableObject{
    private let createTranscationUseCase: CreateTransactionUseCase
    private let updateTransactionUseCase: UpdateTransactionUseCase
    private let deleteTransactionUseCase: DeleteTransactionUseCase
    private let accountUpdateUseCase: UpdateAccountUseCase
    
    static let availableIcons: [String] = ["wallet", "card", "cash", "piggybank", "bank", "safe", "coins"]
    
    @Published var transactionIconName: String = "wallet"
    @Published var transactionIconColorName: String = AppPalette.defaultColor.rawValue
    
    init(createTranscationUseCase: CreateTransactionUseCase, updateTransactionUseCase: UpdateTransactionUseCase, deleteTransactionUseCase: DeleteTransactionUseCase, accountUpdateUseCase: UpdateAccountUseCase) {
        self.createTranscationUseCase = createTranscationUseCase
        self.updateTransactionUseCase = updateTransactionUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
        self.accountUpdateUseCase = accountUpdateUseCase
    }
    
    private var editingTransaction: Transaction?
    
    @Published var selectedAccount: Account?
    @Published var selectedCategory: Category?
    
    @Published var date: Date = .now
    @Published var note: String = ""
    @Published var amount: String = "0"
    
    // Fields
    var categories: [Category] = [] {
        didSet { updateDefaultSelectionIfNeeded() }
    }
    var accounts: [Account] = []

    var incomeCategories: [Category] { categories.filter { $0.type == .income } }

    var expenseCategories: [Category] { categories.filter { $0.type == .expense } }

    @Published var type: TransactionType = .income {
        didSet { updateDefaultSelectionIfNeeded() }
    }

    private func updateDefaultSelectionIfNeeded() {
        // Ensure the selected category matches the current type and exists in the list.
        let list = (type == .income) ? incomeCategories : expenseCategories

        if let current = selectedCategory, list.contains(where: { $0.id == current.id }) {
            return // keep current selection if still valid
        }
        selectedCategory = list.first // or nil if you want to force user selection
    }
    
    @Published var isShowCalendar: Bool = false
    @Published var isShowAccountsForm: Bool = false
    
    func setup(
        transaction: Transaction?,
        accounts: [Account],
        categories: [Category]
    ) {
        
        editingTransaction = transaction
        self.categories = categories
        self.accounts = accounts

        guard let transaction else { return }

        type = transaction.type
        date = transaction.date
        amount = String(transaction.amount)
        note = transaction.note ?? ""
        
        selectedAccount = accounts.first {
            $0.id == transaction.accountId
        }

        selectedCategory = categories.first {
            $0.id == transaction.categoryId
        }
    }
    
    private func signedAmount(type: TransactionType, amount: Double) -> Double {
        switch type {
        case .income: return amount
        case .expense: return -amount
        case .transfer: return 0 // TODO: handle transfers when source/destination accounts are available
        }
    }

    private func updateAccountBalance(accountId: UUID, delta: Double) throws {
        guard let account = accounts.first(where: { $0.id == accountId }) ?? (selectedAccount?.id == accountId ? selectedAccount : nil) else { return }
        let updated = Account(
            id: account.id,
            name: account.name,
            currencyCode: account.currencyCode,
            iconName: account.iconName,
            iconColorName: account.iconColorName,
            balance: account.balance + delta,
            updatedAt: .now,
            createdAt: account.createdAt
        )
        try accountUpdateUseCase.execute(account: updated)
        // Reflect the change in local cache as well
        if let idx = accounts.firstIndex(where: { $0.id == accountId }) {
            accounts[idx] = updated
        }
        if selectedAccount?.id == accountId {
            selectedAccount = updated
        }
    }
    
    func saveTransaction() {
        do {
            let newAmount = Double(amount) ?? 0
            if let editingTransaction {
                // Update existing
                let old = editingTransaction
                let newAccountId = selectedAccount?.id ?? old.accountId
                let newType = type
                let oldSigned = signedAmount(type: old.type, amount: old.amount)
                let newSigned = signedAmount(type: newType, amount: newAmount)

                try updateTransactionUseCase.execute(
                    transaction: Transaction(
                        id: old.id,
                        note: note,
                        date: date,
                        type: newType,
                        amount: newAmount,
                        categoryId: selectedCategory?.id ?? old.categoryId,
                        accountId: newAccountId,
                        createdAt: old.createdAt,
                        updatedAt: .now
                    )
                )

                if old.accountId == newAccountId {
                    let delta = newSigned - oldSigned
                    if delta != 0 { try updateAccountBalance(accountId: newAccountId, delta: delta) }
                } else {
                    if oldSigned != 0 { try updateAccountBalance(accountId: old.accountId, delta: -oldSigned) }
                    if newSigned != 0 { try updateAccountBalance(accountId: newAccountId, delta: newSigned) }
                }
            } else {
                // Create new
                let accountId = selectedAccount?.id ?? UUID()
                try createTranscationUseCase.execute(
                    transaction: Transaction(
                        id: UUID(),
                        note: note,
                        date: date,
                        type: type,
                        amount: newAmount,
                        categoryId: selectedCategory?.id ?? UUID(),
                        accountId: accountId,
                        createdAt: .now,
                        updatedAt: .now
                    )
                )
                let delta = signedAmount(type: type, amount: newAmount)
                if delta != 0 { try updateAccountBalance(accountId: accountId, delta: delta) }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTransaction() {
        guard let editingTransaction else { return }
        do {
            try deleteTransactionUseCase.execute(id: editingTransaction.id)
            let delta = -signedAmount(type: editingTransaction.type, amount: editingTransaction.amount)
            if delta != 0 { try updateAccountBalance(accountId: editingTransaction.accountId, delta: delta) }
        } catch {
            print(error.localizedDescription)
        }
    }
}

