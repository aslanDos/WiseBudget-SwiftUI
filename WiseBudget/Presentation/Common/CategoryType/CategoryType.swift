//
//  CategoryType.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import SwiftUI

enum CategoryType: String, CaseIterable, SwitcherItem {
    case income
    case expense
    
    var title: String {
        switch self {
        case .income: "Income"
        case .expense: "Expense"
        }
    }

    var icon: String {
        switch self {
        case .income: "arrow.down"
        case .expense: "arrow.up"
        }
    }
    
    var color: Color {
        switch self {
        case .income: .green
        case .expense: .red
        }
    }
}
