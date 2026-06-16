//
//  ContentView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 02.05.2026.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var vm = Assembly.shared.createHomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AccountCapsule(iconString: "wallet", iconColor: .appPrimary, accountName: appState.selectedAccount?.name ?? "No Account", backgroundColor: .cardBackground, action: {
                    vm.showAccountsForm = true
                })
                
                Spacer()
                
                HStack {
                    ActionButton(icon: "search", action: {})
                }
            }
            
            CalendarView(
                currentWeek: $vm.currentWeek,
                selectedDate: $vm.selectedDate
            )
            
            HStack {
                Text("\(vm.selectedDate.displayDate)")
                    .poppins(.semibold, 16)
                
                Spacer()
                
                HStack {
                    Text(vm.dailyIncomeAmount.formattedAmount(type: .income, currency: "₸"))
                        .poppins(.regular, 10)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.cardBackground, lineWidth: 1)
                        }
                    
                    Text(vm.dailyExpenseAmount.formattedAmount(type: .expense, currency: "₸"))
                        .poppins(.regular, 10)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.cardBackground, lineWidth: 1)
                        }
                }
            }
            .padding(.top)
            
            ScrollView {
                // Transaction Card
                ForEach(vm.dayTransactions(for: vm.selectedDate)) { transaction in
                    
                    TransactionCard(
                        tr: transaction,
                        action: {
                            appState.selectedTransaction = transaction
                            appState.showTransactionForm = true
                        }
                    )
                }
            }
            
            Spacer()
            
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .background(Color.mainBackground)
        .sheet(isPresented: $vm.showAccountsForm) {
            AccountsView()
                .presentationDetents([.fraction(0.25), .fraction(0.6)])
                .presentationCornerRadius(24)
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            vm.loadWeekTransactions(accountId: appState.selectedAccount?.id, weekDate: vm.currentWeek)
        }
        .onChange(of: vm.currentWeek) { _, newWeek in
            vm.loadWeekTransactions(
                accountId: appState.selectedAccount?.id,
                weekDate: newWeek
            )
        }
        .onChange(of: appState.selectedAccount?.id) { _, newId in
            vm.loadWeekTransactions(
                accountId: newId,
                weekDate: vm.currentWeek
            )
        }
        .onReceive(appState.transactionDidChange) { _ in
            vm.loadWeekTransactions(
                accountId: appState.selectedAccount?.id,
                weekDate: vm.currentWeek
            )
        }
    }
}
