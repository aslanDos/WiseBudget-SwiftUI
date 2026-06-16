//
//  FABButton.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct FABButton: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image("plus")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .padding(.horizontal, 18)
                .background(.appPrimary)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(Pressable())
    }
}

