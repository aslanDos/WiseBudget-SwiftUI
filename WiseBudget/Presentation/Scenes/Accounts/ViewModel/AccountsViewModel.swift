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
    
    @Published var accounts: [Account] = []
    
    func fetchAccounts() {
        do {
            try fetchAccountsUseCase.execute { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.accounts = success
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
