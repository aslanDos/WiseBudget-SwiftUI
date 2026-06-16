//
//  TransactionMapper.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation
import CoreData

struct TransactionMapper {
    static func toDomain(from entity: TransactionEntity) -> Transaction {
        let transaction = Transaction(
            id: entity.id,
            note: entity.note,
            date: entity.date,
            type: TransactionType(rawValue: entity.type) ?? .expense,
            amount: entity.amount,
            categoryId: entity.categoryId,
            accountId: entity.accountId,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt
        )
        return transaction
    }
    
    static func toEntity(from domain: Transaction, context: NSManagedObjectContext) -> TransactionEntity {
        let entity = TransactionEntity(context: context)
        entity.id = domain.id
        entity.note = domain.note
        entity.date = domain.date
        entity.type = domain.type.rawValue
        entity.amount = domain.amount
        entity.categoryId = domain.categoryId
        entity.accountId = domain.accountId
        entity.createdAt = domain.createdAt
        entity.updatedAt = domain.updatedAt
        return entity
    }
}
