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
    init(createAccountUseCase: CreateAccountUseCase) {
        self.createAccountUseCase = createAccountUseCase
    }
    
    @Published var accountName: String = ""
    @Published var accountCurrencyCode: String = "KZT"
    @Published var accountBalance: String = ""
    @Published var accountIconName: String = "wallet"
    @Published var accountIconColorName: String = "appPrimary"
    
    func createNewAccount() {
        do {
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
        } catch {
            print(error.localizedDescription)
        }
    }
}
