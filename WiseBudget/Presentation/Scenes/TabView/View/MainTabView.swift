//
//  MainTabView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 29.05.2026.
//

import SwiftUI

struct MainTabView: View {
    
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
                
                FABButton(action: {})
                
                TabItem(image: "chart", pageType: .analytics, selectedPage: $selectedPage)
                
                TabItem(image: "cog", pageType: .settings, selectedPage: $selectedPage)
            }
            .padding(.top, 10)
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    MainTabView()
}
