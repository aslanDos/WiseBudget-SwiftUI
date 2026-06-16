//
//  MainTabView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var appState: AppState
    @State var selectedPage: TabPage = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
        
            TabView(selection: $selectedPage) {
                HomeView()
                    .tag(TabPage.home)
                
                AccountsView()
                    .tag(TabPage.accounts)
                
                AnalyticsView()
                    .tag(TabPage.analytics)
                
                SettingsView()
                    .tag(TabPage.settings)
            }
            
            HStack {
                TabItem(image: "house", pageType: .home, selectedPage: $selectedPage)
                
                TabItem(image: "wallet", pageType: .accounts, selectedPage: $selectedPage)
                
                FABButton {
                    appState.selectedTransaction = nil
                    appState.showTransactionForm = true
                }
                
                TabItem(image: "chart", pageType: .analytics, selectedPage: $selectedPage)
                
                TabItem(image: "cog", pageType: .settings, selectedPage: $selectedPage)
            }
            .padding(.top, 10)
            .background(.mainBackground)
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 1)
            }
            .sheet(isPresented: $appState.showTransactionForm) {
                TransactionFormView(tr: appState.selectedTransaction)
                    .presentationCornerRadius(24)
            }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
