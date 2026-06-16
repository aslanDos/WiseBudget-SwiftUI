//
//  TransactionForm.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 09.06.2026.
//

import SwiftUI
import Combine

struct TransactionFormView: View {
    
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    let tr: Transaction?
    
    var isEditing: Bool {
        tr != nil
    }
    
    var account: Account? {
        appState.accounts.first {
            $0.id == tr?.accountId
        }
    }
    
    private var isSaveEnabled: Bool {
        (Double(viewModel.amount) ?? 0) > 0
    }
    
    @StateObject var viewModel = Assembly.shared.createTransactionFormViewModel()
    @State private var localSelectedAccount: Account? = nil
    @State private var isShowCategoryPicker: Bool = false
    @State private var categoryScrollID: UUID? = nil
    @State private var scrollViewContentOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            Color.mainBackground
                .ignoresSafeArea()
            
            content
            
        }
        .onAppear {
            if isEditing {
                let account = appState.accounts.first { account in
                    account.id == tr?.accountId
                }
                viewModel.selectedAccount = account ?? appState.accounts.first
                localSelectedAccount = viewModel.selectedAccount
            } else {
                viewModel.selectedAccount = appState.selectedAccount
                localSelectedAccount = viewModel.selectedAccount
            }
        }
        .sheet(isPresented: $viewModel.isShowCalendar) {
            ZStack {
                
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .scaleEffect(0.95)
                    .padding()
                    .onChange(of: viewModel.date) {
                        viewModel.isShowCalendar = false
                    }
            }
            .presentationDetents([.height(360)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.isShowAccountsForm) {
            AccountsView(
                onSelect: { selected in
                    // Only change local state for the transaction form
                    viewModel.selectedAccount = selected
                    localSelectedAccount = selected
                },
                selectedAccountOverride: localSelectedAccount
            )
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
            .presentationDetents([.fraction(0.25), .fraction(0.6)])
        }
        .sheet(isPresented: $isShowCategoryPicker) {
            CategoryPickerView(
                categories: viewModel.type == .income ? viewModel.incomeCategories : viewModel.expenseCategories,
                selected: viewModel.selectedCategory,
                onSelect: { cat in
                    viewModel.selectedCategory = cat
                }
            )
            .presentationDetents([.fraction(0.3), .fraction(0.6)])
            .presentationCornerRadius(24)
            .presentationDragIndicator(.visible)
        }
    }
    
    private var content: some View {
        let categoriesToShow = viewModel.type == .income ? viewModel.incomeCategories : viewModel.expenseCategories
        
        return VStack(spacing: 12) {

            SheetHeader(closeButton: true) {
                TypeSwitcher(selectedItem: $viewModel.type)
            } trailing: {
                if isEditing {
                    SheetHeaderActionButton(color: .red, icon: "trash") {
                        viewModel.deleteTransaction()
                        appState.loadAccounts()
                        appState.transactionDidChange.send()
                        dismiss()
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            amountView
            
            Spacer()
            
            // Main Content
            VStack(alignment: .leading) {
                
                HStack {
                    FieldButton(
                        iconName: viewModel.selectedAccount?.iconName ?? "wallet",
                        iconColor: Color(viewModel.selectedAccount?.iconColorName ?? AppPalette.defaultColor.rawValue),
                        text: viewModel.selectedAccount?.name ?? "Default",
                        action: {
                            withAnimation(.spring()) {
                                viewModel.isShowAccountsForm = true
                            }
                        })
                    
                    Spacer()
                    
                    FieldButton(iconName: "calendar-days", text: viewModel.date.displayDate) {
                        viewModel.isShowCalendar = true
                    }
                }
                
                TextFieldView(placeHolder: "Note", iconName: "feather", background: .mainBackground, text: $viewModel.note)
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categoriesToShow) { category in
                                let isSelected = viewModel.selectedCategory?.id == category.id
                                VStack(spacing: 4) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(category.iconColorName).opacity(0.3))
                                            .frame(width: 38, height: 38)
                                            .shadow(color: isSelected ? Color.black.opacity(0.10) : .clear, radius: 2, x: 0, y: 1)
                                        Image(category.iconName)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(Color(category.iconColorName))
                                            .frame(width: 22, height: 22)
                                    }
                                    .scaleEffect(isSelected ? 1.25 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                                }
                                .onTapGesture { viewModel.selectedCategory = category }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    
                    if let selected = viewModel.selectedCategory {
                        Text(selected.name)
                            .poppins(.semibold, 14, Color(selected.iconColorName))
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 2)
                    }
                }
                .padding(.vertical)
                .background(.mainBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                NumpadView { key in
                    handleNumpad(key)
                } onDeleteLongPress: {
                    viewModel.amount = "0"
                }
                
                FilledButton(
                    text: "Save",
                    fillColor: isSaveEnabled ? .appPrimary : .mainBackground,
                    textColor: isSaveEnabled ? .onAppSecondary : .appPrimary) {
                        viewModel.saveTransaction()
                        appState.loadAccounts()
                        appState.transactionDidChange.send()
                        dismiss()
                    }
            }
            .onAppear {
                viewModel.setup(
                    transaction: tr,
                    accounts: appState.accounts,
                    categories: appState.categories
                )
                print(viewModel.categories)
            }
            .padding(.top, 12)
            .safeAreaPadding(.bottom, 24)
            .padding(.horizontal, 16)
            .background(.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
        .ignoresSafeArea()
        .padding(.top)
    }
    
    private func handleNumpad(_ key: NumpadKey) {
        switch key {

        case .number(let value):

            if viewModel.amount == "0" {
                viewModel.amount = value
                return
            }

            guard viewModel.amount.count < 15 else { return }

            viewModel.amount += value

        case .decimal:

            if viewModel.amount.isEmpty {
                viewModel.amount = "0."
                return
            }

            guard !viewModel.amount.contains(".") else { return }

            viewModel.amount += "."

        case .delete:

            guard !viewModel.amount.isEmpty else { return }

            viewModel.amount.removeLast()

            if viewModel.amount.isEmpty {
                viewModel.amount = "0"
            }
        }
        
        
    }
}

// MARK: AmountView
extension TransactionFormView {
    var amountView: some View {
        Text("\(viewModel.amount) ₸")
            .poppins(.semibold, 32)
            .contentTransition(.numericText())
            .animation(
                .spring(
                    response: 0.15,
                    dampingFraction: 1
                ),
                value: viewModel.amount
            )
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .allowsTightening(true)
            .frame(maxWidth: .infinity)
    }
}

