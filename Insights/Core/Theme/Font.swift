//
//  Font.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
 
struct AppFont {
    static func title() -> Font {
        .system(size: 22, weight: .bold)
    }
    static func headline() -> Font {
        .system(size: 16, weight: .semibold)
    }
    static func body() -> Font {
        .system(size: 14)
    }
    static func caption() -> Font {
        .system(size: 12)
    }
}
