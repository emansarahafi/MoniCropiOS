//
//  potassiumView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct potassiumView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var potassiumValues: [(Date, Double)] = []
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
            .pickerStyle(.menu)
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
            .pickerStyle(.menu)
            .padding()
            .disabled(selectedFruit.isEmpty)
            
            Button(action: {
                getpotassiumValues()
            }, label: {
                Text("Show potassium Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            
            if !potassiumValues.isEmpty {
                potassiumLineChartView(data: potassiumValues)
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
                if !self.fruits.isEmpty && self.selectedFruit.isEmpty {
                    self.selectedFruit = self.fruits[0]
                }
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
                    let id = document.data()["id"] as? String ?? ""
                    if !uniqueIDs.contains(id) && !id.isEmpty {
                        uniqueIDs.append(id)
                    }
                }
                self.ids = uniqueIDs.sorted()
                if !self.ids.isEmpty && self.selectedID.isEmpty {
                    self.selectedID = self.ids[0]
                }
            }
    }

    
    private func getpotassiumValues() {
        potassiumValues.removeAll()
        db.collection("soil_data")
            .whereField("userId", isEqualTo: user?.uid ?? "")
            .whereField("fruit", isEqualTo: selectedFruit)
            .whereField("id", isEqualTo: selectedID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                var values: [(Date, Double)] = []
                for document in documents {
                    let potassiumValue = document.data()["Potassium"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), potassiumValue))
                }
                self.potassiumValues = values.sorted { $0.0 < $1.0 }
            }
    }
}

struct potassiumLineChartView: View {
    var data: [(Date, Double)]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Potassium (K)")
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
