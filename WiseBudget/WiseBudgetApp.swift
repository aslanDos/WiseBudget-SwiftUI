//
//  WiseBudgetApp.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 02.05.2026.
//

import SwiftUI

@main
struct WiseBudgetApp: App {
    @State var path: NavigationPath = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                MainTabView()
//                    .navigationDestination(for: NavigationType.self) { page in
//                        switch page {
//                        case .accountForm:
//                            AccountFormView(path: $path)
//                        }
//                    }
            }
            .onAppear {
                print(FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!)
            }
        }
    }
}
