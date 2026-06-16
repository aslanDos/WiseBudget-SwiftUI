//
//  CalendarView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 07.06.2026.
//

import SwiftUI
import UIKit

struct CalendarView: View {
    
    @Binding var currentWeek: Date
    @Binding var selectedDate: Date
    @State private var slideDirection: Edge = .trailing
    @State private var isMonthExpanded: Bool = false
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("chevron-left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        slideDirection = .leading
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            hapticImpact(.light)
                            if isMonthExpanded {
                                currentWeek = Calendar.current.date(byAdding: .month, value: -1, to: currentWeek) ?? currentWeek
                            } else {
                                currentWeek = currentWeek.addingWeek(-1)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Text(currentWeek.monthYear)
                    .poppins(.semibold)
                    .id(currentWeek.monthYear)
                    .contentTransition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            isMonthExpanded.toggle()
                            hapticImpact(.medium)
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: currentWeek)
                
                Spacer()
                
                Image("chevron-right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .onTapGesture {
                        slideDirection = .trailing
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            hapticImpact(.light)
                            if isMonthExpanded {
                                currentWeek = Calendar.current.date(byAdding: .month, value: 1, to: currentWeek) ?? currentWeek
                            } else {
                                currentWeek = currentWeek.addingWeek(1)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
            }
            
            Divider()
            
            HStack {
                ForEach(Date.weekDaySymbols, id: \.self) { day in
                    Text(day)
                        .poppins()
                        .frame(maxWidth: .infinity)
                }
            }
            
            Group {
                if isMonthExpanded {
                    ZStack {
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(currentWeek.monthGridDates, id: \.self) { date in
                                Text("\(date.day)")
                                    .poppins(date.isToday ? .semibold : .regular, 14, selectedDate.isSameDay(as: date) ? .onAppSecondary : (date.isInSameMonth(as: currentWeek) ? .textPrimary : .secondary))
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
                                        hapticImpact(.light)
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                            currentWeek = date
                                        }
                                    }
                            }
                        }
                        .id(currentWeek.monthYear)
                        .transition(weekTransition)
                    }
                } else {
                    ZStack {
                        HStack {
                            ForEach(
                                currentWeek.weekDates,
                                id: \.self
                            ) { date in
                                Text("\(date.day)")
                                    .poppins(date.isToday ? .semibold : .regular, 14, selectedDate.isSameDay(as: date) ? .onAppSecondary : .textPrimary)
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
                        .id(currentWeek)
                        .transition(weekTransition)
                    }
                }
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.9), value: currentWeek)
            .animation(.spring(response: 0.3, dampingFraction: 0.9), value: isMonthExpanded)
            .gesture(mainDragGesture)
        }
        .padding()
        .background(.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .bottom) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.vertical, 6)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                        isMonthExpanded.toggle()
                        hapticImpact(.medium)
                    }
                }
        }
    }
    
    private var weekTransition: AnyTransition {
        switch slideDirection {
        case .leading:
            return .asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .trailing).combined(with: .opacity)
            )
        default:
            return .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            )
        }
    }
    
    private var mainDragGesture: some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .local)
            .onEnded { value in
                let dx = value.translation.width
                let dy = value.translation.height
                if abs(dx) > abs(dy), abs(dx) > 30 {
                    // Horizontal swipe: navigate weeks or months
                    if dx < 0 {
                        // Swipe left -> next period
                        slideDirection = .trailing
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            hapticImpact(.light)
                            if isMonthExpanded {
                                currentWeek = Calendar.current.date(byAdding: .month, value: 1, to: currentWeek) ?? currentWeek
                            } else {
                                currentWeek = currentWeek.addingWeek(1)
                            }
                        }
                    } else {
                        // Swipe right -> previous period
                        slideDirection = .leading
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            hapticImpact(.light)
                            if isMonthExpanded {
                                currentWeek = Calendar.current.date(byAdding: .month, value: -1, to: currentWeek) ?? currentWeek
                            } else {
                                currentWeek = currentWeek.addingWeek(-1)
                            }
                        }
                    }
                } else {
                    // Vertical swipe: expand/collapse
                    if dy > 40 {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            isMonthExpanded = true
                            hapticImpact(.medium)
                        }
                    } else if dy < -40 {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                            isMonthExpanded = false
                            hapticImpact(.medium)
                        }
                    }
                }
            }
    }
    
    private func hapticImpact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

