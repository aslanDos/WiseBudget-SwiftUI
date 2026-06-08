//
//  CalendarView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 07.06.2026.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var currentWeek: Date
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("chevron-left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        currentWeek = currentWeek.addingWeek(-1)
                    }
                
                Spacer()
                
                Text(currentWeek.monthYear)
                    .poppins(.semibold)
                
                Spacer()
                
                Image("chevron-right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        currentWeek = currentWeek.addingWeek(1)
                    }
            }
            
            HStack {
                ForEach(Date.weekDaySymbols, id: \.self) { day in
                    Text(day)
                        .poppins()
                        .frame(maxWidth: .infinity)
                }
            }
            
            HStack {
                ForEach(
                    currentWeek.weekDates,
                    id: \.self
                ) { date in
                    Text("\(date.day)")
                
                        .poppins(date.isToday ? .semibold : .regular)
                        .foregroundStyle(selectedDate.isSameDay(as: date) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(4)
                        .background {
                            if selectedDate.isSameDay(as: date) {
                                Circle()
                                    .fill(.appPrimary)
                            }
                        }
                        .onTapGesture {
                            selectedDate = date
                        }

                }
            }
        }
        .padding()
        .background(.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
