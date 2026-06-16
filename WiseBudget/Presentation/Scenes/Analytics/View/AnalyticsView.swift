//
//  AnalyticsView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Analytics")
                .poppins(.semibold, 18)
                .padding(.vertical)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .background(.mainBackground)
        
    }
}

#Preview {
    AnalyticsView()
}
