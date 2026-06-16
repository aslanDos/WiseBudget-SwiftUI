//
//  CategoryMapper.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation
import CoreData

struct CategoryMapper {
    static func toDomain(from entity: CategoryEntity) -> Category {
        let category = Category(
            id: entity.id,
            order: entity.order,
            name: entity.name,
            iconName: entity.iconName,
            iconColorName: entity.iconColorName,
            type: CategoryType(rawValue: entity.type) ?? .income
        )
        
        return category
    }
    
    static func toEntity(from domain: Category, context: NSManagedObjectContext) -> CategoryEntity {
        let entity = CategoryEntity(context: context)
        entity.id = domain.id
        entity.order = domain.order
        entity.name = domain.name
        entity.iconName = domain.iconName
        entity.iconColorName = domain.iconColorName
        entity.type = domain.type.rawValue
        
        return entity
    }
}
