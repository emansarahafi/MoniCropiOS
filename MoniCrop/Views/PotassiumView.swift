//
//  PotassiumView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct PotassiumView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var potassiumValues: [(Date, Double)] = []
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
            .accessibilityIdentifier("potassiumPickerFruit")
            .accessibilityLabel("Select crop item for potassium")
            .accessibilityHint("Choose a crop to load available IDs")
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
            .accessibilityIdentifier("potassiumPickerID")
            .accessibilityLabel("Select ID for potassium")
            .accessibilityHint("Choose an item identifier to show potassium values")
            .disabled(selectedFruit.isEmpty)
            
            Button(action: {
                getpotassiumValues()
            }, label: {
                Text("Show Potassium Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            .accessibilityIdentifier("showPotassiumValuesButton")
            .accessibilityLabel("Show potassium values")
            .accessibilityHint("Displays potassium measurements for the selected item")
            
            if !potassiumValues.isEmpty {
                PotassiumLineChartView(data: potassiumValues)
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

struct PotassiumView_Previews: PreviewProvider {
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
