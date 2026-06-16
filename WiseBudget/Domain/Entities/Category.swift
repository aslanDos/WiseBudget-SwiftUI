//
//  Category.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation

struct Category: Identifiable, Equatable {
    let id: UUID
    let order: Int16
    let name: String
    let iconName: String
    let iconColorName: String
    let type: CategoryType
    
    init(
        id: UUID = UUID(),
        order: Int16,
        name: String,
        iconName: String,
        iconColorName: String,
        type: CategoryType
    ) {
        self.id = id
        self.order = order
        self.name = name
        self.iconName = iconName
        self.iconColorName = iconColorName
        self.type = type
    }
}

extension Category {

    static func income(
        _ name: String,
        icon: String,
        iconColorName: String,
        order: Int16
    ) -> Category {
        Category(
            order: order,
            name: name,
            iconName: icon,
            iconColorName: iconColorName,
            type: .income,
        )
    }

    static func expense(
        _ name: String,
        icon: String,
        iconColorName: String,
        order: Int16
    ) -> Category {
        Category(
            order: order,
            name: name,
            iconName: icon,
            iconColorName: iconColorName,
            type: .expense
        )
    }
}
