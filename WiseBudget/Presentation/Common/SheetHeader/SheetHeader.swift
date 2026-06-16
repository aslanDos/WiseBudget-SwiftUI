//
//  SheetHeader.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//

import SwiftUI

struct SheetHeader<Content: View, Trailing: View>: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let closeButton: Bool
    
    @ViewBuilder let content: () -> Content
    @ViewBuilder let trailing: () -> Trailing
    
    var body: some View {
        ZStack {
            
            content()
            
            HStack {
                // Close sheet button
                if (closeButton) {
                    SheetHeaderActionButton(icon: "x", action: dismiss.callAsFunction)
                }
                
                Spacer()
                
                trailing()
                
            }
        }
    }
}

extension SheetHeader where Content == Text, Trailing == EmptyView {
    init(
        title: String,
        closeButton: Bool = true
    ) {
        self.closeButton = closeButton

        self.content = {
            Text(title)
        }

        self.trailing = {
            EmptyView()
        }
    }
}

extension SheetHeader where Content == Text {
    init(
        title: String,
        closeButton: Bool = true,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.closeButton = closeButton

        self.content = {
            Text(title)
        }

        self.trailing = trailing
    }
}
