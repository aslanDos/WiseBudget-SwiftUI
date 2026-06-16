//
//  AccountFormViewModel.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import Combine

class AccountFormViewModel: ObservableObject {
    private let createAccountUseCase: CreateAccountUseCase
    private let updateAccountUseCase: UpdateAccountUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    
    init(createAccountUseCase: CreateAccountUseCase, updateAccountUseCase: UpdateAccountUseCase, deleteAccountUseCase: DeleteAccountUseCase) {
        self.createAccountUseCase = createAccountUseCase
        self.updateAccountUseCase = updateAccountUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
    }
    
    private var editingAccount: Account?
    var formType: FormType<Account> { editingAccount == nil ? .create : .edit(editingAccount!)}
    
    @Published var accountName: String = ""
    @Published var accountCurrencyCode: String = "KZT"
    @Published var accountBalance: String = ""
    @Published var accountIconName: String = "wallet"
    @Published var accountIconColorName: String = AppPalette.defaultColor.rawValue
    
    func setup(account: Account?) {
        
        editingAccount = account
        
        guard let account else { return }
        
        accountName = account.name
        accountIconColorName = account.iconColorName
        accountBalance = String(account.balance)
        accountCurrencyCode = account.currencyCode
    }
    
    func saveAccount() {
        do {
            if let editingAccount {
                try updateAccountUseCase.execute(
                    account: Account(
                        id: editingAccount.id,
                        name: accountName,
                        currencyCode: accountCurrencyCode,
                        iconName: accountIconName,
                        iconColorName: accountIconColorName,
                        balance: Double(accountBalance) ?? 0,
                        updatedAt: .now,
                        createdAt: editingAccount.createdAt
                    )
                )
            } else {
                try createAccountUseCase.execute(
                    account: Account(
                        id: UUID(),
                        name: accountName,
                        currencyCode: accountCurrencyCode,
                        iconName: accountIconName,
                        iconColorName: accountIconColorName,
                        balance: Double(accountBalance) ?? 0,
                        updatedAt: .now,
                        createdAt: .now
                    )
                )
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() {
        guard let editingAccount else { return }
        
        do {
            try deleteAccountUseCase.execute(id: editingAccount.id)
        } catch {
            print(error.localizedDescription)
        }  
    }
}
