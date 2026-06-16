//
//  FieldView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 17.06.2026.
//

import SwiftUI

struct FieldButton: View {
    var iconName: String
    var iconColor: Color = .textSecondary
    var text: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(iconColor.opacity(0.5))
                
                Text(text)
                    .poppins(.regular, 12, .textSecondary)
            }
            .frame(height: 44)
            .padding(.horizontal, 16)
            .background(.mainBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
