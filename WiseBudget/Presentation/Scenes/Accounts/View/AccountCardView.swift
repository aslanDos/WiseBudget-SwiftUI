//
//  AccountCardView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 05.06.2026.
//

import SwiftUI

struct AccountCardView: View {
    
    let account: Account?
    var selected: Bool = false
    var onEditTapped: (() -> Void)?
    
    @Binding var toggleMode: Bool
    @Binding var isShowAccountForm: Bool
    
    var body: some View {
        HStack {
            Image(account?.iconName ?? "wallet")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(12)
                .foregroundStyle(Color(account?.iconColorName ?? "appPrimary"))
                .background(Color(account?.iconColorName ?? "appPrimary").opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading) {
                Text(account?.name ?? "Default")
                
                Text(account?.balance.formattedAmount(decimals: 2) ?? "0")
            }
            .poppins(.regular, 14)
            
            Spacer()
            
            Image(toggleMode ? "menu" : "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .onTapGesture {
                    if(!toggleMode) {
                        onEditTapped?()
                        isShowAccountForm = true
                    }
                }
        }
        .padding(.vertical, 8)
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .background(
            selected
                ? .appBorder.opacity(0.5)
                : .cardBackground
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    selected ? .appBorder : .clear,
                    lineWidth: 2
                )
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .overlay(alignment: .bottomTrailing) {
            if selected {
                Image("star.fill")
                    .poppins(.semibold, 10)
                    .padding(6)
                    .background(.cardBackground)
                    .clipShape(Circle())
                    .offset(x: 4, y: 4)
            }
        }
    }
}
