//
//  CategoriesFormViewModel.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import Foundation
import Combine

class CategoriesFormViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    var incomeCategories: [Category] {
        categories.filter { $0.type == .income }
    }

    var expenseCategories: [Category] {
        categories.filter { $0.type == .expense }
    }
}
