//
//  TransactionCard.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 08.06.2026.
//

import SwiftUI

struct TransactionCard: View {
    
    @EnvironmentObject private var appState: AppState
    
    let tr: Transaction
    let action: () -> Void
    
    private var amountColor: Color {
        if tr.type == .income { .green}
        else if tr.type == .expense { .red}
        else {.textPrimary}
    }
    
    var category: Category? {
        appState.categories.first {
            $0.id == tr.categoryId
        }
    }
    
    var account: Account? {
        appState.accounts.first {
            $0.id == tr.accountId
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            
            HStack(spacing: 12) {
                
                let category = appState.categories.first {
                    $0.id == tr.categoryId
                }
                
                Image(category?.iconName ?? "wallet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .foregroundStyle(Color(category?.iconColorName ?? "appPrimary"))
                    .background(Color(category?.iconColorName ?? "appPrimary").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading) {
                    Text(category?.name ?? "Default")
                        .poppins(.semibold, 14)
                    
                    HStack {
                        if let accountName = account?.name {
                            Text(accountName)
                                .poppins(.regular, 10)
                                .foregroundStyle(.secondary)
                        }
                        
                        if let _ = account, let trNote = tr.note, !trNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text("•")
                                .poppins(.regular, 10)
                        }
                        
                        if let trNote = tr.note, !trNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            
                            Text(trNote)
                                .poppins(.regular, 10)
                        }
                        
                    }
                }
                
                Spacer()
                
                Text(
                    tr.amount.formattedAmount(type: tr.type, currency: "₸", decimals: 2)
                )
                .poppins(.regular, 14, amountColor)
            }
            .padding(.vertical, 8)
            .padding(.leading, 8)
            .padding(.trailing, 16)
            .background(.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(Pressable())
    }
}


