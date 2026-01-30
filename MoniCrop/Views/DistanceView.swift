//
//  DistanceView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct DistanceView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var distanceValues: [(Date, Double)] = []
    @State private var fruits: [String] = []
    @State private var ids: [String] = []
    
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            Picker("Select a crop item", selection: $selectedFruit) {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .accessibilityIdentifier("distancePickerFruit")
            .accessibilityLabel("Select crop item for distance")
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
            .accessibilityIdentifier("distancePickerID")
            .accessibilityLabel("Select ID for distance")
            .accessibilityHint("Choose an item identifier to show distance values")
            .disabled(selectedFruit.isEmpty)
            
            Button(action: {
                getdistanceValues()
            }, label: {
                Text("Show Distance Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            .accessibilityIdentifier("showDistanceValuesButton")
            .accessibilityLabel("Show distance values")
            .accessibilityHint("Displays distance measurements for the selected item")
            
            if !distanceValues.isEmpty {
                DistanceLineChartView(data: distanceValues)
                    .padding()
            }
        }
        .onAppear {
            loadFruits()
        }
    }
    
    private func loadFruits() {
        let userId = Auth.auth().currentUser?.uid ?? ""
        db.collection("soil_data")
            .whereField("userId", isEqualTo: userId)
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
        let userId = Auth.auth().currentUser?.uid ?? ""
        db.collection("soil_data")
            .whereField("userId", isEqualTo: userId)
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
    
    private func getdistanceValues() {
        distanceValues.removeAll()
        let userId = Auth.auth().currentUser?.uid ?? ""
        db.collection("soil_data")
            .whereField("userId", isEqualTo: userId)
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
                    let distanceValue = document.data()["Distance"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), distanceValue))
                }
                self.distanceValues = values.sorted { $0.0 < $1.0 }
            }
    }
}

struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 1.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 1.2),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 1.1),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 1.3),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 1.25),
            (now, 1.4)
        ]
        NavigationStack {
            DistanceLineChartView(data: sample)
                .frame(height: 320)
                .padding()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
