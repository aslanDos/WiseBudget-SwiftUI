//
//  AccountCardView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 05.06.2026.
//

import SwiftUI

struct AccountCardView: View {
    
    var iconName: String
    var accountName: String
    var accountBalance: String
    
    var body: some View {
        HStack {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(14)
                .foregroundStyle(.blue)
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading) {
                Text(accountName)
                Text(accountBalance)
            }
            
            Spacer()
            
            Image("chevron-right")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
        }
        .padding()
        .background(.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
