//
//  BodySignalsView.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
import Charts
 
struct BodySignalsView: View {
    let data: [SymptomData]
    var total: Double {
        data.map { $0.value }.reduce(0, +)
    }
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Symptom Trends")
                    .font(.system(size: 18, weight: .semibold))
                Text("Compared to last cycle")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                ZStack {
                    Chart {
                        ForEach(data) { item in
                            SectorMark(
                                angle: .value("Value", item.value),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(item.color.gradient)
                            .annotation(position: .overlay) {
                                VStack {
                                    Text("\(Int(item.value))%")
                                        .font(.caption)
                                        .bold()
                                    Text(item.name)
                                        .font(.caption2)
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(height: 220)
                    
                }
            }
        }
    }
}
