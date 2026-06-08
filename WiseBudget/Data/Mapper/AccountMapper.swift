//
//  AccountMapper.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import CoreData

struct AccountMapper {
    static func toDomain(from entity: AccountEntity) -> Account {
        let account = Account(
            id: entity.id,
            name: entity.name,
            currencyCode: entity.currencyCode,
            iconName: entity.iconName,
            iconColorName: entity.iconColorName,
            balance: entity.balance,
            updatedAt: entity.updatedAt,
            createdAt: entity.createdAt
        )
        
        return account
    }
    
    static func toEntity(from domain: Account, context: NSManagedObjectContext) -> AccountEntity {
        let entity = AccountEntity(context: context)
        entity.id = domain.id
        entity.name = domain.name
        entity.currencyCode = domain.currencyCode
        entity.iconName = domain.iconName
        entity.iconColorName = domain.iconColorName
        entity.balance = domain.balance
        entity.updatedAt = domain.updatedAt
        entity.createdAt = domain.createdAt
        
        return entity
    }
}
