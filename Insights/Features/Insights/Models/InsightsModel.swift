//
//  InsightsModel.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import Foundation
import SwiftUI
 
struct InsightsModel {

    let stabilityScore: Int

    let stabilityData: [StabilityPoint]

    let cycleData: [CyclePoint]
    let metabolicData: [MetabolicPoint]

    let symptomData : [SymptomData]
    let lifestyleData : [LifestyleCategory: [LifestyleData]]

}
 
struct StabilityPoint: Identifiable {

    let id = UUID()

    let month: String

    let value: Double

}
 
struct CyclePoint: Identifiable {

    let id = UUID()

    let month: String

    let days: Int
    let flowDays: Int

}
struct MetabolicPoint: Identifiable {
    let id = UUID()
    let month: String
    let bodyValue: Double
}
struct SymptomData: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let color: Color
}
enum LifestyleCategory: String, CaseIterable, Identifiable {
    case sleep = "Sleep"
    case hydration = "Hydration"
    case caffeine = "Caffeine"
    case exercise = "Exercise"
    
    var id: String { self.rawValue }
}

struct LifestyleData: Identifiable {
    let id = UUID()
    let day: Int
    let value: Double // 0 → 1 intensity
    let category: LifestyleCategory
}
 
