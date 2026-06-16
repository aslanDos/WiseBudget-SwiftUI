//
//  FieldView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 01.06.2026.
//

import SwiftUI

struct TextFieldView: View {
    var placeHolder: String = ""
    var iconName: String
    var background: Color = .cardBackground
    @Binding var text : String
    var body: some View {
        TextField(placeHolder, text: $text)
            .poppins(.regular, 12, .textSecondary)
            .frame(height: 44)
            .padding(.horizontal, 40)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .leading) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.textSecondary.opacity(0.5))
                    .padding(.leading, 16)
            }
    }
}
