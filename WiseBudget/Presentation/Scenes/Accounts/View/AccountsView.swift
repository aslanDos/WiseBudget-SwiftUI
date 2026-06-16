//
//  AccountsView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct AccountsView: View {
    var onSelect: ((Account) -> Void)? = nil
    var selectedAccountOverride: Account? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var appState: AppState
    
    @StateObject var viewModel = Assembly.shared.createAccountsViewModel()
    
    var body: some View {
        VStack {
            
            SheetHeader(title: "Accounts") {
                HStack {
                    SheetHeaderActionButton(icon: "plus") {
                        viewModel.editingAccount = nil
                        viewModel.isShowAccountForm = true
                    }
                    SheetHeaderActionButton(icon: "arrow-up-down") {
                        viewModel.toggleAccounts.toggle()
                    }
                }
            }
            
            ScrollView {
                ForEach(appState.accounts) { item in
                    AccountCardView(
                        account: item,
                        selected: (selectedAccountOverride ?? appState.selectedAccount) == item,
                        onEditTapped: {
                            viewModel.editingAccount = item
                        },
                        toggleMode: $viewModel.toggleAccounts,
                        isShowAccountForm: $viewModel.isShowAccountForm
                    )
                    .onTapGesture {
                        if let onSelect {
                            onSelect(item)
                            dismiss()
                        } else {
                            appState.selectedAccount = item
                            dismiss()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.vertical)
            
            Spacer()

        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .background(.mainBackground)
        .sheet(isPresented: $viewModel.isShowAccountForm) {
            AccountFormView(account: viewModel.editingAccount)
                .presentationCornerRadius(12)
                .presentationDragIndicator(.visible)
        }
        .onReceive(appState.accountsDidChange) { _ in
            appState.loadAccounts()
        }
        .onChange(of: viewModel.isShowAccountForm) { _, isPresented in
            if !isPresented {
                appState.loadAccounts()
            }
        }
//        .onAppear {
//            viewModel.fetchAccounts()
//        }
    }
}

