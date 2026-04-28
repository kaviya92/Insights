//
//  LifestyleImpactView.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
import Charts

struct LifestyleImpactView: View {
    let data: [LifestyleCategory: [LifestyleData]]
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 6),
        count: 7
    )
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HStack {
                    Text("Lifestyle Impact")
                        .font(AppFont.headline())
                    Spacer()
                    HStack(spacing: 4) {
                        Text("4 months")
                            .font(AppFont.caption())
                            .foregroundColor(.textSecondary)
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                }
                .padding(.bottom, Spacing.sm)

                VStack(alignment: .leading, spacing: Spacing.md) {
                    ForEach(LifestyleCategory.allCases) { category in
                        HStack {
                            Text(category.rawValue)
                                .font(AppFont.body())
                            Spacer()
                            LazyVGrid(columns: columns, spacing: 6) {
                                ForEach(data[category] ?? []) { item in
                                    cellView(for: item)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
extension LifestyleImpactView {
    func cellView(for item: LifestyleData) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(color(for: item.value, category: item.category))
            .frame(height: 20)
    }
    
    func color(for value: Double, category: LifestyleCategory) -> Color {
        let baseColor: Color
        switch category {
        case .sleep:
            baseColor = Color.purpleBody // Similar to purple in the image
        case .hydration:
            baseColor = Color.red // Similar to pink/red in the image
        case .caffeine:
            baseColor = Color.accentGreen // Similar to green in the image
        case .exercise:
            baseColor = Color.red // Similar to pink/red in the image
        }

        switch value {
        case 0..<0.2:
            return baseColor.opacity(0.2)
        case 0.2..<0.4:
            return baseColor.opacity(0.4)
        case 0.4..<0.6:
            return baseColor.opacity(0.6)
        case 0.6..<0.8:
            return baseColor.opacity(0.8)
        default:
            return baseColor
        }
    }
}
