//
//  PotassiumLineChartView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct PotassiumLineChartView: View {
    var data: [(Date, Double)]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Potassium (mg/kg)")
                .font(.headline)
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
            
            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .trailing, spacing: 0) {
                    let minData = data.map { $0.1 }.min() ?? 0
                    let maxData = data.map { $0.1 }.max() ?? 1
                    ForEach(0..<5) { i in
                        let value = maxData - (maxData - minData) * Double(i) / 4
                        Text(String(format: "%.0f", value))
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .frame(height: 50, alignment: .top)
                    }
                }
                .frame(width: 30)
                
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.05))
                        
                        Path { path in
                            for i in 1..<5 {
                                let y = CGFloat(i) * geometry.size.height / 5
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                            }
                        }
                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                        
                        Path { path in
                            guard data.count > 0 else { return }
                            let minData = data.map { $0.1 }.min() ?? 0
                            let maxData = data.map { $0.1 }.max() ?? 1
                            let dataRange = maxData - minData
                            
                            let xScale = data.count > 1 ? geometry.size.width / CGFloat(data.count - 1) : 0
                            let yScale = dataRange > 0 ? geometry.size.height / CGFloat(dataRange) : 0
                            
                            let firstY = dataRange > 0 ? geometry.size.height - (data[0].1 - minData) * yScale : geometry.size.height / 2
                            path.move(to: CGPoint(x: 0, y: firstY))
                            
                            for i in 1..<data.count {
                                let x = CGFloat(i) * xScale
                                let y = dataRange > 0 ? geometry.size.height - (data[i].1 - minData) * yScale : geometry.size.height / 2
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                        .stroke(Color(red: 148/255, green: 178/255, blue: 2/255), lineWidth: 2.5)
                    }
                    .padding(4)
                }
                .frame(height: 250)
            }
            
            HStack {
                Spacer().frame(width: 30)
                HStack {
                    if !data.isEmpty {
                        Text(data.first?.0.formatted(date: .abbreviated, time: .omitted) ?? "")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Spacer()
                        Text(data.last?.0.formatted(date: .abbreviated, time: .omitted) ?? "")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct PotassiumLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 80.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 85.0),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 83.0),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 87.0),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 86.0),
            (now, 90.0)
        ]
        return PotassiumLineChartView(data: sample)
            .frame(height: 320)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
