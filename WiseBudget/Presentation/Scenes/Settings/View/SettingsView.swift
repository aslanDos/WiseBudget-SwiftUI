//
//  SettingsView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct SettingsView: View {
    @State var showCategoriesForm: Bool = false
    var body: some View {
        VStack (alignment: .leading) {
            Text("Settings")
                .poppins(.semibold, 18)
                .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Button {
                        showCategoriesForm = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "square.grid.2x2")
                                .font(.system(size: 20))
                                .foregroundStyle(.appPrimary)
                                        
                            Text("Categories")
                                .poppins(.medium, 16)
                                .foregroundStyle(.appPrimary)
                                            
                            Spacer()
                                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showCategoriesForm) {
            CategoriesFormView()
                .presentationCornerRadius(24)
                .presentationDragIndicator(.visible)
        }
        .padding(.horizontal, 16)
        .background(.mainBackground)
    }
}

#Preview {
    SettingsView()
}
