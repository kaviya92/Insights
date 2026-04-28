//
//  InsightsService.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//
import SwiftUI

protocol InsightsServiceProtocol {
    func fetchInsights() async -> InsightsModel
}
final class InsightsService: InsightsServiceProtocol {
    func fetchInsights() async -> InsightsModel {
        // simulate API delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return InsightsModel(
            stabilityScore: 78,
            stabilityData: [
                .init(month: "Jan", value: 24),
                .init(month: "Feb", value: 26),
                .init(month: "Mar", value: 28),
                .init(month: "Apr", value: 32)
            ],
            cycleData: [
                .init(month: "Jan", days: 28, flowDays: 5),
                .init(month: "Feb", days: 30, flowDays: 6),
                .init(month: "Mar", days: 28, flowDays: 4),
                .init(month: "Apr", days: 32, flowDays: 7),
                .init(month: "May", days: 26, flowDays: 5),
                .init(month: "Jun", days: 26, flowDays: 4)
            ],
            metabolicData: [
                .init(month: "Jan", bodyValue: 50),
                .init(month: "Feb", bodyValue: 52),
                .init(month: "Mar", bodyValue: 55),
                .init(month: "Apr", bodyValue: 60),
                .init(month: "May", bodyValue: 58),
                .init(month: "Jun", bodyValue: 56)
            ],
            symptomData: [
                .init(name: "Mood", value: 30, color: .purple),
                .init(name: "Bloating", value: 31, color: .pink),
                .init(name: "Fatigue", value: 21, color: .orange),
                .init(name: "Acne", value: 17, color: .blue)
            ],
            lifestyleData: [
                .sleep: (1...35).map { day in
                    LifestyleData(day: day, value: Double.random(in: 0...1), category: .sleep)
                },
                .hydration: (1...35).map { day in
                    LifestyleData(day: day, value: Double.random(in: 0...1), category: .hydration)
                },
                .caffeine: (1...35).map { day in
                    LifestyleData(day: day, value: Double.random(in: 0...1), category: .caffeine)
                },
                .exercise: (1...35).map { day in
                    LifestyleData(day: day, value: Double.random(in: 0...1), category: .exercise)
                }
            ]
        )
    }
}
