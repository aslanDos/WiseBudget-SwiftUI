//
//  NumpadView.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 17.06.2026.
//

import SwiftUI

enum NumpadKey: Hashable {
    case number(String)
    case decimal
    case delete
    
    var title: String {
        switch self {
        case .number(let value):
            return value
        case .decimal:
            return "."
        case .delete:
            return ""
        }
        
    }
}
    
struct NumpadView: View {
    
    let keys: [NumpadKey] = [
        .number("1"), .number("2"), .number("3"),
        .number("4"), .number("5"), .number("6"),
        .number("7"), .number("8"), .number("9"),
        .decimal, .number("0"), .delete
    ]
    
    let columns = Array(
        repeating: GridItem(.flexible(), spacing: 4),
        count: 3
    )
    
    var onTap: (NumpadKey) -> Void
    var onDeleteLongPress: () -> Void
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(keys, id: \.self) { key in
                Button {
                    onTap(key)
                } label: {
                    cell(for: key)
                }
                .buttonStyle(.plain)
                .highPriorityGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onEnded { _ in
                            if key == .delete {
                                onDeleteLongPress()
                            }
                        }
                )
            }
        }
    }
    
    @ViewBuilder
    private func cell(for key: NumpadKey) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.mainBackground)
            
            switch key {
            case .delete:
                Image("delete")
                
            default:
                Text(key.title)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
    }
}

