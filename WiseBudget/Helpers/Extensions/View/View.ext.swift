//
//  View.ext.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 30.05.2026.
//

import SwiftUI

extension View {
    func poppins(_ font: Poppins = .regular, _ size: CGFloat = 14, _ color: Color = .textPrimary) -> some View {
        self
            .foregroundStyle(color)
            .font(.custom(font.rawValue, size: size))
    }
}
