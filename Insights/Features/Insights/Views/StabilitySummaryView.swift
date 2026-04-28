//
//  StabilitySummaryView.swift
//  Insights
//
//  Created by KaviyaPriya on 22/04/26.
//

import SwiftUI
import Charts

struct StabilitySummaryView: View {
    
    let score: Int
    
    let data: [StabilityPoint]
    @State private var animate = false
    @State private var selected: StabilityPoint?
    @State private var selectedPointLocation: CGPoint? = nil
    var body: some View {
        
        CardView {
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Stability Summary")
                    .font(.system(size: 18, weight: .semibold))
                Text("Based on your recent logs and symptom patterns")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                HStack(alignment: .bottom, spacing: 6) {
                    Text("\(score)%")
                        .font(.system(size: 30, weight: .bold))
                    Text("Stability Score")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, 4)
                }
                Chart {
                    ForEach(data) { item in
                        LineMark(
                            x: .value("Month", item.month),
                            y: .value("Value", animate ? item.value : 0)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(StrokeStyle(lineWidth: 3))
                        .foregroundStyle(Color.purpleBody)
                        AreaMark(
                            x: .value("Month", item.month),
                            y: .value("Value", animate ? item.value : 0)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.purpleBody.opacity(0.25),
                                    Color.purpleBody.opacity(0.05),
                                    .clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }
                .frame(height: 170)
                .chartYScale(domain: 20...96)
                .chartYAxis {
                    AxisMarks(position: .leading) { _ in
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
                                            selected = data.first { $0.month == month }
                                        }
                                    }
                                    .onEnded { _ in
                                        selected = nil
                                        selectedPointLocation = nil
                                    }
                            )
                    }
                }
            }
            .overlay(alignment: .topLeading) {
                if let selected, let location = selectedPointLocation {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Stability Improving")
                            .font(.caption2)
                        Text("\(Int(selected.value))%")
                            .font(.caption)
                            .bold()
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black)
                            .overlay(alignment: .bottom) {
                                Triangle()
                                    .fill(Color.black)
                                    .frame(width: 15, height: 8)
                                    .offset(y: 8)
                            }
                    )
                    .foregroundColor(.white)
                    .offset(x: location.x - 60, y: location.y - 60)
                    .transition(.scale)
                }
            }
            
        }
        
    }
}
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}



