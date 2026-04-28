//
//  InsightsViewModel.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class InsightsViewModel: ObservableObject {
    
    @Published var stabilityScore: Int = 0
    @Published var stabilityData: [StabilityPoint] = []
    @Published var cycleData: [CyclePoint] = []
    @Published var metabolicData: [MetabolicPoint] = []
    @Published var symptomData: [SymptomData] = []
    @Published var lifestyleData: [LifestyleCategory: [LifestyleData]] = [:]

    @Published var isLoading: Bool = false
    private let service: InsightsServiceProtocol
    init(service: InsightsServiceProtocol) {
        self.service = service
    }
    func loadData() async {
        isLoading = true
        let result = await service.fetchInsights()
        self.stabilityScore = result.stabilityScore
        self.stabilityData = result.stabilityData
        self.cycleData = result.cycleData
        self.metabolicData = result.metabolicData
        self.symptomData = result.symptomData
        self.lifestyleData = result.lifestyleData

        isLoading = false
    }
}
