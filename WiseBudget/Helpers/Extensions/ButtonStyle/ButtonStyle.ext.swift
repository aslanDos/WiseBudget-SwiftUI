//
//  ButtonStyle.ext.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 19.06.2026.
//

import Foundation
import SwiftUI

struct Pressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(
                configuration.isPressed ? 0.95 : 1
            )
            .animation(
                .spring(
                    response: 0.45,
                    dampingFraction: 0.7
                ),
                value: configuration.isPressed
            )
    }
}
