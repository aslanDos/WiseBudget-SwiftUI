//
//  AppPalete.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 19.06.2026.
//

import Foundation
import SwiftUI

enum AppPalette: String, CaseIterable, Codable, Identifiable {
    case red100
    case red200
    case red300
    case red400
    case red500
    case red600
    case red700
    case red800
    
    case pink100
    case pink200
    case pink300
    case pink400
    case pink500
    case pink600
    case pink700
    case pink800
    
    case purple100
    case purple200
    case purple300
    case purple400
    case purple500
    case purple600
    case purple700
    case purple800
    
    case blue100
    case blue200
    case blue300
    case blue400
    case blue500
    case blue600
    case blue700
    case blue800

    case cyan100
    case cyan200
    case cyan300
    case cyan400
    case cyan500
    case cyan600
    case cyan700
    case cyan800
    
    case green100
    case green200
    case green300
    case green400
    case green500
    case green600
    case green700
    case green800
    
    case yellow100
    case yellow200
    case yellow300
    case yellow400
    case yellow500
    case yellow600
    case yellow700
    case yellow800
    
    case orange100
    case orange200
    case orange300
    case orange400
    case orange500
    case orange600
    case orange700
    case orange800
    
    case brown100
    case brown200
    case brown300
    case brown400
    case brown500
    case brown600
    case brown700
    case brown800
    
    case gray100
    case gray200
    case gray300
    case gray400
    case gray500
    case gray600
    case gray700
    case gray800
}

extension AppPalette {
    
    static let collorsToPick: [AppPalette] = [.red400, .red500, .pink400, .pink500, .purple400, .purple500, .blue400, .blue500, .cyan400, .cyan500, .green400, .green500, .yellow400, .yellow500, .orange400, .orange500, .brown400, .brown500, .gray400, .gray500]
    
    static let reds: [AppPalette] = [
        .red100, .red200, .red300, .red400, .red500, .red600, .red700, .red800
    ]
    
    static let pinks: [AppPalette] = [
        .pink100, .pink200, .pink300, .pink400, .pink500, .pink600, .pink700, .pink800
    ]
    
    static let purples: [AppPalette] = [
        .purple100, .purple200, .purple300, .purple400, .purple500, .purple600, .purple700, .purple800
    ]
    
    static let blues: [AppPalette] = [
        .blue100, .blue200, .blue400, .blue500, .blue600, .blue700, .blue800
    ]
    
    static let cyans: [AppPalette] = [
        .cyan100, .cyan200, .cyan300, .cyan400, .cyan500, .cyan600, .cyan700, .cyan800
    ]
    
    static let greens: [AppPalette] = [
        .green100, .green200, .green300, .green400, .green500, .green600, .green700, .green800
    ]
    
    static let yellows: [AppPalette] = [
        .yellow100, .yellow200, .yellow300, .yellow400, .yellow500, .yellow600, .yellow700, .yellow800
    ]
    
    static let oranges: [AppPalette] = [
        .orange100, .orange200, .orange300, .orange400, .orange500, .orange600, .orange700, .orange800
    ]
    
    static let brown: [AppPalette] = [
        .brown100, .brown200, .brown300, .brown400, .brown500, .brown600, .brown700, .brown800
    ]
    
    static let grays: [AppPalette] = [
        .gray100, .gray200, .gray300, .gray400, .gray500, .gray600, .gray700, .gray800
    ]
}

extension AppPalette {
    var color: Color {
        Color(rawValue)
    }
    
    static let defaultColor: AppPalette = .blue400
}

extension AppPalette {
    var id: String { rawValue }
}

