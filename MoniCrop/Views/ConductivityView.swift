//
//  ConductivityView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct ConductivityView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var conductivityValues: [(Date, Double)] = []
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
            .accessibilityIdentifier("conductivityPickerFruit")
            .accessibilityLabel("Select crop item for conductivity")
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
            .accessibilityIdentifier("conductivityPickerID")
            .accessibilityLabel("Select ID for conductivity")
            .accessibilityHint("Choose an item identifier to show conductivity values")
            .disabled(selectedFruit.isEmpty)
            
            Button(action: {
                getconductivityValues()
            }, label: {
                Text("Show Conductivity Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            .accessibilityIdentifier("showConductivityValuesButton")
            .accessibilityLabel("Show conductivity values")
            .accessibilityHint("Displays conductivity measurements for the selected item")
            
            if !conductivityValues.isEmpty {
                ConductivityLineChartView(data: conductivityValues)
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
    
    private func getconductivityValues() {
        conductivityValues.removeAll()
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
                    let conductivityValue = document.data()["Conductivity"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), conductivityValue))
                }
                self.conductivityValues = values.sorted { $0.0 < $1.0 }
            }
    }
}
struct ConductivityView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 200.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 220.0),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 210.0),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 230.0),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 225.0),
            (now, 240.0)
        ]
        NavigationStack {
            ConductivityLineChartView(data: sample)
                .frame(height: 320)
                .padding()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
