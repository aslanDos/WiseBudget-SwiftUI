//
//  Transaction.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID
    let note: String?
    let date: Date
    let type: TransactionType
    let amount: Double
    let categoryId: UUID
    let accountId: UUID
    let createdAt: Date
    let updatedAt: Date
}
