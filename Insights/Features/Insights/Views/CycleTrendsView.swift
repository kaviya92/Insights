//
//  Untitled.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//
import SwiftUI
import Charts
extension CyclePoint {
    var barColor: Color {
        if days > 29 {
            return .accentGreen   // longer cycle
        } else {
            return .purpleBody // normal
        }
    }
}
struct CycleTrendsView: View {

    let data: [CyclePoint]
    @State private var animate = false
    @State private var selectedCycle: CyclePoint?
    var body: some View {

        CardView {

            VStack(alignment: .leading) {

                Text("Cycle Trends").font(AppFont.headline())

                Chart {

                    ForEach(data) { item in

                        BarMark(

                            x: .value("Month", item.month),

                            yStart: .value("Flow Days Start", 0),
                            yEnd: .value("Flow Days End", animate ? item.flowDays : 0)

                        )
                        .foregroundStyle(Color.accentRed)
                        .cornerRadius(5)

                        BarMark(

                            x: .value("Month", item.month),

                            yStart: .value("Days Start", item.flowDays),
                            yEnd: .value("Days End", animate ? item.days : item.flowDays)

                        )
                        .foregroundStyle(item.barColor)
                        .cornerRadius(5)
                        .annotation(position: .top) {
                            Text("\(item.days)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
//                        .annotation(position: .trailing, alignment: .bottom) {
//                            VStack(spacing: 4) {
//                                Image(systemName: "drop.fill")
//                                    .font(.system(size: 10))
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 4)
//                                    .padding(.vertical, 2)
//                                    .background(Capsule().fill(Color.gray.opacity(0.7)))
//                                Image(systemName: "sun.max.fill")
//                                    .font(.system(size: 10))
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 4)
//                                    .padding(.vertical, 2)
//                                    .background(Capsule().fill(Color.gray.opacity(0.7)))
//                            }
//                        }

                    }

                }
                .chartYAxis {
                    AxisMarks(preset: .automatic) {
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
                .frame(height: 180)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.8)) {
                        animate = true
                    }
                }
                .chartOverlay { proxy in
                    GeometryReader { geo in
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let x = value.location.x
                                        if let month: String = proxy.value(atX: x) {
                                            selectedCycle = data.first { $0.month == month }
                                        }
                                    }
                                    .onEnded { _ in
                                        selectedCycle = nil
                                    }
                            )
                    }
                }
            }
            .overlay(alignment: .topTrailing) {
                if let selectedCycle {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Cycle: \(selectedCycle.days) days")
                            .font(.caption2)
                        Text("Flow: \(selectedCycle.flowDays) days")
                            .font(.caption2)
                    }
                    .padding(8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .transition(.scale)
                }
            }
        }
    }
}
