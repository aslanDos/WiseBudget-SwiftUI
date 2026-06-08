//
//  AccountCapsule.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 30.05.2026.
//

import SwiftUI

struct AccountCapsule: View {
    var iconString: String
    var iconColor: Color
    var accountName: String
    
    var body: some View {
        HStack {
            Image(iconString)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundStyle(iconColor)
            
            Text(accountName)
                .poppins(.semibold, 12)
            
            Image("chevron-right")
                .resizable()
                .scaledToFit()
                .frame(width: 8, height: 8)
        }
        .padding(.horizontal,12)
        .padding(.vertical, 10)
        .background(.onAppSecondary)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .buttonStyle(.glass)
    }
}
