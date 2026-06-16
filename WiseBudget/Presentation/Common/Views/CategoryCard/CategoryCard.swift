//
//  CategoryCard.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import SwiftUI

struct CategoryCard: View {
    
    var categoryName: String
    var categoryIconName: String
    var categoryIconColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(categoryIconName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(12)
                .foregroundStyle(categoryIconColor)
                .background(categoryIconColor.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(categoryName)
                .poppins(.regular, 14)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .background(.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

