//
//  Account.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation

struct Account: Identifiable, Equatable {
    let id: UUID
    let name: String
    let currencyCode: String
    let iconName: String
    let iconColorName: String
    let balance: Double
    let updatedAt: Date
    let createdAt: Date
}
