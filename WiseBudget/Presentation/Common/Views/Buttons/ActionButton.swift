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
                .frame(width: 18, height: 18)
                .foregroundStyle(.appPrimary)
                .padding(.horizontal,12)
                .padding(.vertical, 10)
                .background(.onAppSecondary)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            
        }

    }
}

