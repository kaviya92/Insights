//
//  BodyMetabolicView.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
import Charts
 
struct BodyMetabolicView: View {
    let data: [MetabolicPoint]
    @State private var selectedTimeRange: String = "Monthly"
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Body & Metabolic Trends")
                    .font(.system(size: 18, weight: .semibold))
                HStack {
                    VStack(alignment: .leading) {
                        Text("Your weight")
                            .font(AppFont.headline())
                        Text("in kg")
                            .font(AppFont.caption())
                            .foregroundColor(.textSecondary)
                    }
                    Spacer()
                    HStack(spacing: 0) {
                        Text("Monthly")
                            .font(AppFont.caption())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedTimeRange == "Monthly" ? Color.black : Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .foregroundColor(selectedTimeRange == "Monthly" ? .white : .textSecondary)
                            .onTapGesture {
                                selectedTimeRange = "Monthly"
                            }
                        Text("Weekly")
                            .font(AppFont.caption())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedTimeRange == "Weekly" ? Color.black : Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .foregroundColor(selectedTimeRange == "Weekly" ? .white : .textSecondary)
                            .onTapGesture {
                                selectedTimeRange = "Weekly"
                            }
                    }
                }
                chartView
            }
        }
    }
}
extension BodyMetabolicView {
    var chartView: some View {
        Chart {
            ForEach(data) { item in
                AreaMark(
                    x: .value("Month", item.month),
                    y: .value("Body", item.bodyValue)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.red.opacity(0.5),
                            Color.red.opacity(0.1),
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                LineMark(
                    x: .value("Month", item.month),
                    y: .value("Body", item.bodyValue)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.red)
                PointMark(
                    x: .value("Month", item.month),
                    y: .value("Body", item.bodyValue)
                )
                .foregroundStyle(Color.red)
            }
        }
        .frame(height: 170)
        .chartYScale(domain: 20...90)
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisGridLine()
                    .foregroundStyle(Color.gray.opacity(0.2))
                AxisValueLabel()
                    .font(.system(size: 10))
                    .foregroundStyle(Color.gray)
            }
        }
        .chartXAxis {
            AxisMarks(values: data.map { $0.month }) {
                AxisValueLabel()
                    .font(.system(size: 10))
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.top, 10)
        .padding(.trailing, 8)
    }
}
