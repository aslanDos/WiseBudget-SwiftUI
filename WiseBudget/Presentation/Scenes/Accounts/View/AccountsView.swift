//
//  AccountsView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct AccountsView: View {
    @State var isShowAccountForm: Bool = false
    @StateObject var viewModel = Assembly.createAccountsViewModel()
    
    var body: some View {
        VStack {
            Button {
                isShowAccountForm.toggle()
            } label: {
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
            }
            
            ForEach(viewModel.accounts) { item in
                AccountCardView(iconName: item.iconName, accountName: item.name, accountBalance: "\(item.balance)")
            }

        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .background(.mainBackground)
        .sheet(isPresented: $isShowAccountForm) {
            AccountFormView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: isShowAccountForm) { _, isPresented in
            if !isPresented {
                viewModel.fetchAccounts()
            }
        }
        .onAppear {
            viewModel.fetchAccounts()
        }
    }
}

#Preview {
    AccountsView()
}
