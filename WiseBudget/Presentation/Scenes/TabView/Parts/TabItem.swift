//
//  TabItem.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import SwiftUI

struct TabItem: View {
    
    var image: String
    var pageType: TabPage
    @Binding var selectedPage: TabPage
    
    var body: some View {
        Button {
            selectedPage = pageType
        } label: {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                
            }
            .foregroundStyle(pageType == selectedPage ? .appPrimary : .appPrimary.opacity(0.5))
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
        }
    }
}
