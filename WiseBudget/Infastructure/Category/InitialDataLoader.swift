//
//  InitialDataLoader.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation
import CoreData

//Salary
//Gift
//Other

//Food
//Health
//Transaport
//Clothes
//Home
//Bills
//Travel
//Entertainment
//Other

final class InitialDataLoader {
    private let context = PersistentContainer.shared.persistentContainer.viewContext
    
    func loadDefaultCategoriesIfNeeded() throws {
//        let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        
        let defaultCategories: [Category] = [
            // MARK: Income
            .income("Salary", icon: "briefcase-business", iconColorName: AppPalette.green400.rawValue, order: 1),
            .income("Freelance", icon: "laptop", iconColorName: AppPalette.purple400.rawValue, order: 2),
            .income("Gift", icon: "gift", iconColorName: AppPalette.yellow800.rawValue, order: 3),
            .income("Other", icon: "square", iconColorName: AppPalette.gray400.rawValue, order: 4),
            
            // MARK: Expense
            .expense("Food", icon: "beef", iconColorName: AppPalette.red400.rawValue, order: 5),
            .expense("Health", icon: "stethoscope", iconColorName: AppPalette.pink700.rawValue, order: 6),
            .expense("Transport", icon: "car", iconColorName: AppPalette.yellow800.rawValue, order: 7),
            .expense("Clothes", icon: "shirt", iconColorName: AppPalette.pink700.rawValue, order: 8),
            .expense("Home", icon: "house", iconColorName: AppPalette.blue400.rawValue, order: 9),
            .expense("Bills", icon: "receipt-text", iconColorName: AppPalette.orange600.rawValue, order: 10),
            .expense("Travel", icon: "plane", iconColorName: AppPalette.green400.rawValue, order: 11),
            .expense("Entertainment", icon: "gamepad-2", iconColorName: AppPalette.purple400.rawValue, order: 12),
            .expense("Other", icon: "square", iconColorName: AppPalette.gray400.rawValue, order: 13),
        ]
        
        for (index, category) in defaultCategories.enumerated() {
            let entity = CategoryMapper.toEntity(from: category, context: context)
            entity.order = Int16(index)
        }
        
        try context.save()

    }
}
