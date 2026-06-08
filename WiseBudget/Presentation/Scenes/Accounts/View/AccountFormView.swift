//
//  AccountFormView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import SwiftUI

struct AccountFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isEditing: Bool = false
    @StateObject var viewModel = Assembly.createAccountFormViewModel()
    var body: some View {
        VStack(spacing: 24) {
            
            // Header
            ZStack {
                
                Text("New Account")
                    .poppins(.regular, 18)
                
                HStack {
                    // Close sheet button
                    Button {
                        dismiss()
                    } label: {
                        Image("x")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        Image("trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                    }
                    
                }
            }
            
            // Icon
            Image("wallet")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(14)
                .foregroundStyle(.blue)
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            FieldView(
                placeHolder: "Name",
                text: $viewModel.accountName
            )
            
            FieldView(
                placeHolder: "Balance",
                text: $viewModel.accountBalance
            )
            
            FieldView(
                placeHolder: "Currency",
                text: $viewModel.accountCurrencyCode
            )
            
            FilledButton(
                text: "Save",
                fillColor: .appPrimary,
                textColor: .white
            ) {
                viewModel.createNewAccount()
                dismiss()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(.mainBackground)
    }
}

#Preview {
    AccountFormView()
}

