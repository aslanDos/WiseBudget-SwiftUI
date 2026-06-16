//
//  CategoriesForm.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import SwiftUI

struct CategoriesFormView: View {
    
    @State private var categoryType: CategoryType = .expense
    @EnvironmentObject private var appState: AppState
    @StateObject var viewModel = Assembly.shared.createCategoriesFormViewModel()
    
    var body: some View {
        
        VStack {
            
            SheetHeader(closeButton: true) {
                TypeSwitcher(selectedItem: $categoryType)
            } trailing: {
                HStack {
                    SheetHeaderActionButton(icon: "plus", action: {
                        //add
                    })
                    SheetHeaderActionButton(icon: "arrow-up-down", action: {
                        //sort
                    })
                }
            }
            
            Spacer()
            
            ScrollView {
                
                VStack {
                    if(categoryType == .income) {
                        ForEach(viewModel.incomeCategories) { item in
                            CategoryCard(categoryName: item.name, categoryIconName: item.iconName, categoryIconColor: Color(item.iconColorName))
                        }
                    } else {
                        ForEach(viewModel.expenseCategories) { item in
                            CategoryCard(categoryName: item.name, categoryIconName: item.iconName, categoryIconColor: Color(item.iconColorName))
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.vertical)
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical)
        .background(.mainBackground)
        .onAppear {
            viewModel.categories = appState.categories
            print(viewModel.categories)
        }
    }
}
