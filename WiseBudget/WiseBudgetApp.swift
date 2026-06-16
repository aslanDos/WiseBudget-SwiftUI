//
//  WiseBudgetApp.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 02.05.2026.
//

import SwiftUI

@main
struct WiseBudgetApp: App {
    
    @StateObject private var appState: AppState = AppState()
    @State var path: NavigationPath = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                
                if(appState.isSplashFinished) {
                    
                    MainTabView()
                        .environmentObject(appState)
                        .task {
                            appState.initialize()
                        }
                    //                    .navigationDestination(for: NavigationType.self) { page in
                    //                        switch page {
                    //                        case .accountForm:
                    //                            AccountFormView(path: $path)
                    //                        }
                    //                    }
                } else {
                    SplashView(isFinished: $appState.isSplashFinished)
                }
            }
            .onAppear {
                print(FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!)
            }
        }
    }
}
