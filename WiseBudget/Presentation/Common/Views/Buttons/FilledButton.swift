//
//  FilledButton.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 05.06.2026.
//

import SwiftUI

struct FilledButton: View {
    var text: String
    var fillColor: Color
    var textColor: Color = .onAppSecondary
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(text)
                .poppins(.medium, 12, textColor)
                .padding(.vertical, 12)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(fillColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }

    }
}
