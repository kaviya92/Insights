//
//  InsightsView.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
 
struct InsightsView: View {
    @StateObject private var viewModel =
            InsightsViewModel(service: InsightsService())
    
    var body: some View {
       // ScrollView(.horizontal, showsIndicators: false) {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    header
                    
                    StabilitySummaryView(
                        score: viewModel.stabilityScore,
                        data: viewModel.stabilityData
                    )
                    CycleTrendsView(data: viewModel.cycleData)
                    //                CycleTrendsView()
                    BodyMetabolicView(data: viewModel.metabolicData)
                    BodySignalsView(data: viewModel.symptomData)
                   LifestyleImpactView(data: viewModel.lifestyleData)
                }
                .padding(.bottom, 80)
                .padding()
            }
            .background(Color.background)
            .task {
                   await viewModel.loadData()
               }
            CustomTabBar()
        }
    }
}
extension InsightsView {
    var header: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.title2)
            Spacer()
            Text("Insights")
                .font(AppFont.title())
            Spacer()
            Image(systemName: "ellipsis.circle")
                .font(.title2)
        }
    }
}
