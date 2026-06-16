//
//  AccountFormView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import SwiftUI
import Combine

struct AccountFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    
    let account: Account?
    
    var isEditing: Bool {
        account != nil
    }
    
    @StateObject var viewModel = Assembly.shared.createAccountFormViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            SheetHeader(title: account?.name ?? "New Account") {
                if isEditing {
                    SheetHeaderActionButton(
                        color: .red,
                        icon: "trash"
                    ) {
                        viewModel.deleteAccount()
                        appState.accountsDidChange.send()
                        dismiss()
                    }
                }
            }
                        
            Spacer()
            
            // Icon
            Image("wallet")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(14)
                .foregroundStyle(Color(viewModel.accountIconColorName))
                .background(Color(viewModel.accountIconColorName).opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(AppPalette.collorsToPick) { palette in
                        let isSelected = viewModel.accountIconColorName == palette.rawValue
                        RoundedRectangle(cornerRadius: 8)
                            .fill(palette.color)
                            .frame(width: 32, height: 32)
                            .shadow(color: isSelected ? Color.black.opacity(0.10) : .clear, radius: 2, x: 0, y: 1)
                            .scaleEffect(isSelected ? 1.25 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                            .onTapGesture {
                                viewModel.accountIconColorName = palette.rawValue
                                print(viewModel.accountIconColorName)
                            }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
            }
            .background(.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 2)
            .frame(height: 50)
            
            TextFieldView(
                placeHolder: "Name",
                iconName: "a-large-small",
                text: $viewModel.accountName
            )
            
            TextFieldView(
                placeHolder: "Balance",
                iconName: "dollar-sign",
                text: $viewModel.accountBalance
            )
            
            TextFieldView(
                placeHolder: "Currency",
                iconName: "currency",
                text: $viewModel.accountCurrencyCode
            )
            
            
            FilledButton(
                text: "Save",
                fillColor: .appPrimary,
                textColor: .onAppSecondary
            ) {
                viewModel.saveAccount()
                dismiss()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical)
        .background(.mainBackground)
        .onAppear {
            viewModel.setup(account: account)
        }
    }
}

