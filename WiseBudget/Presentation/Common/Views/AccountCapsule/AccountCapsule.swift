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
    var backgroundColor: Color?
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(iconString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(iconColor)
                
                Text(accountName)
                    .poppins(.semibold, 12)
                
                Image("chevron-right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 8)
            }
            .padding(10)
            .frame(
                height: UIConstants.controlHeight - 4
            )
            .clipShape(
                Capsule()
            )
        }
        .buttonStyle(.glass)
    }
}
