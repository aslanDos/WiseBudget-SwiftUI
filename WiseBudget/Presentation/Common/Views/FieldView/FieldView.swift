//
//  FieldView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 01.06.2026.
//

import SwiftUI

struct FieldView: View {
    var placeHolder: String = ""
    @Binding var text : String
    var body: some View {
        TextField(placeHolder, text: $text)
            .frame(height: 48)
            .padding(.horizontal, 44)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .leading) {
                Image("a-large-small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 14)
            }
    }
}
