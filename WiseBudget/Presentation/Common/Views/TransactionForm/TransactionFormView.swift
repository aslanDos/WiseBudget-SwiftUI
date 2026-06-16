//
//  TransactionForm.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 09.06.2026.
//

import SwiftUI

struct TransactionForm: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Header
            ZStack {
                
                Text("New Transaction")
                    .poppins(.regular, 18)
                
                HStack {
                    // Close sheet button
                    Button {
                        dismiss()
                    } label: {
                        Image("x")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .frame(width: 36, height: 36)
                            .background(.cardBackground)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    if (isEditing) {
                        Button {
                        //
                        } label: {
                            Image("trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .frame(width: 36, height: 36)
                                .foregroundStyle(.red)
                                .background(.cardBackground)
                                .clipShape(Circle())
                        }
                    } else {
                        EmptyView()
                    }
                    
                }
            }

        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 32)
        .background(.mainBackground)
    }
}
