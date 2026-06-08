//
//  ContentView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 02.05.2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentWeek = Date()
    @State var selectedDate = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AccountCapsule(iconString: "wallet", iconColor: .appPrimary, accountName: "Freedom")
                
                Spacer()
                
                ActionButton(icon: "cog", action: {})
            }
            
            CalendarView(
                currentWeek: $currentWeek,
                selectedDate: $selectedDate
            )
            
            HStack {
                Text("\(selectedDate.displayDate)")
                    .poppins(.semibold, 16)
                
                Spacer()
                
                HStack {
                    Text("+ 30,000")
                        .poppins(.regular, 10)
                        .padding(6)
                        .background(.cardBackground)
                        .clipShape(Capsule())
                    
                    Text("- 20,000")
                        .poppins(.regular, 10)
                        .padding(6)
                        .background(.cardBackground)
                        .clipShape(Capsule())
                    
                }
            }
            
            ScrollView {
                // Transaction Card
                TransactionCard()
            }
            
            Spacer()
            
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .background(.mainBackground)
    }
}
