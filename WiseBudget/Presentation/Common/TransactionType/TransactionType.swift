//
//  TransactionType.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import SwiftUI

enum TransactionType: String, CaseIterable, SwitcherItem {
    case income
    case expense
    case transfer
    
    var title: String {
        switch self {
        case .income: "Income"
        case .expense: "Expense"
        case .transfer: "Transfer"
        }
    }
    
    var icon: String {
        switch self {
        case .income: "arrow.down"
        case .expense: "arrow.up"
        case .transfer: "arrow.left.arrow.right"
        }
    }
    
    var color: Color {
        switch self {
        case .income: .green
        case .expense: .red
        case .transfer: .appPrimary
        }
    }
}
