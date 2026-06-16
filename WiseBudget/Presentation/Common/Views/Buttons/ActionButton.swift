//
//  ActionButton.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 07.06.2026.
//

import SwiftUI

struct ActionButton: View {
    var icon: String
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .frame(
                    width: UIConstants.controlHeight,
                    height: UIConstants.controlHeight
                )
                .foregroundStyle(.textPrimary)
                .clipShape(
                    Circle()
                )
        }
        .buttonStyle(.glass)

    }
}

