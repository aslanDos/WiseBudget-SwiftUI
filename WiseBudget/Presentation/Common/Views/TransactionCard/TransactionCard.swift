//
//  TransactionCard.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 08.06.2026.
//

import SwiftUI

struct TransactionCard: View {
    var body: some View {
        HStack {
            Image("wallet")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(12)
                .foregroundStyle(.blue)
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading) {
                Text("Category")
                    .poppins(.semibold, 16)
                
                Text("Account Name")
                    .poppins(.regular, 12)
                    
            }
            
            Spacer()
            
            Text("+ 30,013 T")
                .poppins(.regular, 16)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


