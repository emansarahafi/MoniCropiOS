//
//  MoistureView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct MoistureView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var moistureValues: [(Date, Double)] = []
    @State private var fruits: [String] = []
    @State private var ids: [String] = []
    
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    var body: some View {
        VStack {
            Picker("Select a crop item", selection: $selectedFruit) {
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
                getmoistureValues()
            }, label: {
                Text("Show Moisture Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            
            if !moistureValues.isEmpty {
                MoistureLineChartView(data: moistureValues)
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
    
    private func getmoistureValues() {
        moistureValues.removeAll()
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
                    let moistureValue = document.data()["Moisture"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), moistureValue))
                }
                self.moistureValues = values.sorted { $0.0 < $1.0 }
            }
    }
}

struct MoistureView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 30.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 35.0),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 33.0),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 37.0),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 36.0),
            (now, 40.0)
        ]
        return MoistureLineChartView(data: sample)
            .frame(height: 320)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
