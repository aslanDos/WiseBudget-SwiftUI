//
//  HomeViewModel.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 09.06.2026.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let fetchTransactionsUseCase: FetchTransactionsUseCase
    init(fetchTransactionsUseCase: FetchTransactionsUseCase, fetchCategoriesUseCase: FetchCategoriesUseCase) {
        self.fetchTransactionsUseCase = fetchTransactionsUseCase
    }
    
    @Published var showAccountsForm: Bool = false
    
    @Published var currentWeek = Date()
    @Published var selectedDate = Date()
    
    @Published var weekTransactions: [Transaction] = []
    
    var dailyIncomeAmount: Double {
        dayTransactions(for: selectedDate)
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    var dailyExpenseAmount: Double {
        dayTransactions(for: selectedDate)
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    func loadWeekTransactions(
        accountId: UUID?,
        weekDate: Date
    ) {
        guard let accountId else {
            print("Account is nil")
            return
        }

        let calendar = Calendar.current

        guard let weekInterval = calendar.dateInterval(
            of: .weekOfYear,
            for: weekDate
        ) else {
            return
        }

        do {
            try fetchTransactionsUseCase.execute(accountId: accountId, startDate: weekInterval.start, endDate: weekInterval.end ) { result in
                switch result {
                    
                case .success(let success):
                    DispatchQueue.main.async {
                        self.weekTransactions = success
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
            
    }
    
    func dayTransactions(for date: Date) -> [Transaction] {
        let result = weekTransactions.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
        
        return result
    }
}
