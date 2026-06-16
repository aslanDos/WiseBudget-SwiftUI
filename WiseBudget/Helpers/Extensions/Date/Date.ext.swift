//
//  Date.ext.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 07.06.2026.
//

import Foundation

extension Date {
    
    static let dayMonthDateFormatter: DateFormatter = {
        let formmatter = DateFormatter()
        formmatter.locale = Locale.current
        formmatter.dateFormat = "d MMMM YYYY"
        return formmatter
    } ()
    
    static let withoutDayMonthDateFormatter: DateFormatter = {
        let formmatter = DateFormatter()
        formmatter.locale = Locale.current
        formmatter.dateFormat = "MMMM YYYY"
        return formmatter
    } ()
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var weekDates: [Date] {
        let calendar = Calendar.current
        
        guard let interval = calendar.dateInterval(
            of: .weekOfYear,
            for: self
        ) else {
            return []
        }
        
        return (0..<7).compactMap {
            calendar.date(
                byAdding: .day,
                value: $0,
                to: interval.start
            )
        }
    }
    
    var monthYear: String {
        Self.withoutDayMonthDateFormatter.string(from: self)
    }
    
    func addingWeek(_ value: Int) -> Date {
        Calendar.current.date(
            byAdding: .weekOfYear,
            value: value,
            to: self
        ) ?? self
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func isInSameMonth(as other: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: other, toGranularity: .month)
    }

    var monthGridDates: [Date] {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: self)
        guard let firstOfMonth = calendar.date(from: comps) else { return [] }

        let firstWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: firstOfMonth)) ?? firstOfMonth

        let monthRange = calendar.range(of: .day, in: .month, for: firstOfMonth) ?? 1..<31
        let lastOfMonth = calendar.date(byAdding: .day, value: (monthRange.count - 1), to: firstOfMonth) ?? firstOfMonth

        let lastWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: lastOfMonth)) ?? lastOfMonth
        let lastWeekEnd = calendar.date(byAdding: .day, value: 6, to: lastWeekStart) ?? lastOfMonth

        var dates: [Date] = []
        var d = firstWeekStart
        while d <= lastWeekEnd {
            dates.append(d)
            guard let next = calendar.date(byAdding: .day, value: 1, to: d) else { break }
            d = next
            if dates.count > 42 { break } // safety guard
        }
        return dates
    }
    
    static let weekDaySymbols = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
}

extension Date {
    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()
    
    var displayDate: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let year = Calendar.current.component(.year, from: self)
        
        if year == currentYear {
            Self.displayDateFormatter.dateFormat = "d MMMM"
        } else {
            Self.displayDateFormatter.dateFormat = "d MMMM yyyy"
        }
        
        return Self.displayDateFormatter.string(from: self)
    }
}

