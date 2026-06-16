//
//  SplashView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import SwiftUI

struct SplashView: View {
    
    @State private var scale: CGFloat = 0.7
    
    @Binding var isFinished: Bool
    
    var body: some View {
        ZStack {
            
            Color(.mainBackground)
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                Text("Wise")
                
                Text("Budget")
                    .foregroundStyle(.appPrimary)
            }
            .poppins(.bold, 28)
            .scaleEffect(scale)
        
        }
        .onAppear() {
            withAnimation(.easeOut(duration: 1)) {
                scale = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isFinished = true
            }
        }
    }
}

