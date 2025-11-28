//
//  phosphorusView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct phosphorusView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var phosphorusValues: [(Date, Double)] = []
    @State private var fruits: [String] = []
    @State private var ids: [String] = []
    
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    var body: some View {
        VStack {
            Picker("Select a fruit", selection: $selectedFruit) {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
            }
            .padding()
            .onChange(of: selectedFruit) { _ in
                loadIDsForFruit()
                selectedID = ""
            }
            
            Picker("Select an ID", selection: $selectedID) {
                ForEach(ids, id: \.self) { id in
                    Text(id)
                }
            }
            .padding()
            .disabled(selectedFruit.isEmpty)

            
            Button(action: {
                getphosphorusValues()
            }, label: {
                Text("Show phosphorus Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            
            if !phosphorusValues.isEmpty {
                phosphorusLineChartView(data: phosphorusValues)
                    .frame(height: 300)
                    .padding()
            }
        }
        .onAppear {
            loadFruits()
        }
    }
    
    private func loadFruits() {
        db.collection("soil_data")
            .whereField("userId", isEqualTo: user?.uid ?? "")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                var uniqueFruits: [String] = []
                for document in documents {
                    let fruit = document.data()["fruit"] as? String ?? ""
                    if !uniqueFruits.contains(fruit) && !fruit.isEmpty {
                        uniqueFruits.append(fruit)
                    }
                }
                self.fruits = uniqueFruits.sorted()
            }
    }
    
    private func loadIDsForFruit() {
        guard !selectedFruit.isEmpty else {
            ids = []
            return
        }
        db.collection("soil_data")
            .whereField("userId", isEqualTo: user?.uid ?? "")
            .whereField("fruit", isEqualTo: selectedFruit)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                var uniqueIDs: [String] = []
                for document in documents {
                    let id = document.documentID
                    if !uniqueIDs.contains(id) {
                        uniqueIDs.append(id)
                    }
                }
                self.ids = uniqueIDs.sorted()
            }
    }
    
    private func getphosphorusValues() {
        phosphorusValues.removeAll()
        db.collection("soil_data")
            .whereField("userId", isEqualTo: user?.uid ?? "")
            .whereField("fruit", isEqualTo: selectedFruit)
            .whereField("id", isEqualTo: selectedID)
            .order(by: "Timestamp")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                for document in documents {
                    let phosphorusValue = document.data()["Phosphorus"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    phosphorusValues.append((timestamp.dateValue(), phosphorusValue))
                }
            }
    }
}

struct phosphorusLineChartView: View {
    var data: [(Date, Double)]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background grid
                Path { path in
                    // Vertical lines
                    for i in 1..<7 {
                        let x = CGFloat(i) * geometry.size.width / 7
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                    }
                    // Horizontal lines
                    for i in 1..<5 {
                        let y = CGFloat(i) * geometry.size.height / 5
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                }
                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5]))
                
                // Line chart
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
                .stroke(Color.blue, lineWidth: 2)
            }
        }
    }
}
