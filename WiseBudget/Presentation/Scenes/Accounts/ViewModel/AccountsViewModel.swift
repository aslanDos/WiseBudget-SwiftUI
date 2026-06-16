//
//  AccountViewModel.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import Combine

class AccountsViewModel: ObservableObject {
    private let fetchAccountsUseCase: FetchAccountsUseCase
    init(fetchAccountsUseCase: FetchAccountsUseCase) {
        self.fetchAccountsUseCase = fetchAccountsUseCase
    }
    
    @Published var isShowAccountForm: Bool = false
    @Published var toggleAccounts: Bool = false
    @Published var editingAccount: Account?
    @Published var accounts: [Account] = []
    
    func setUp() {
        
    }
}
