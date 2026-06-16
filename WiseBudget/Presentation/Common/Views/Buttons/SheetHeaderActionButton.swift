//
//  SheetHeaderActionButton.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import SwiftUI

struct SheetHeaderActionButton: View {
    
    var color: Color = .textPrimary
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
                .frame(width: 14, height: 14)
                .frame(
                    width: UIConstants.controlHeight,
                    height: UIConstants.controlHeight
                )
                .clipShape(Circle())
        }
        .buttonStyle(.glass)
    }
}

