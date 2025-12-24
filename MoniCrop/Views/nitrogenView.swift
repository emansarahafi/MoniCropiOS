//
//  NitrogenView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct NitrogenView: View {
    @State private var selectedFruit = ""
    @State private var selectedID = ""
    @State private var nitrogenValues: [(Date, Double)] = []
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
            .accessibilityIdentifier("nitrogenPickerFruit")
            .accessibilityLabel("Select crop item for nitrogen")
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
            .accessibilityIdentifier("nitrogenPickerID")
            .accessibilityLabel("Select ID for nitrogen")
            .accessibilityHint("Choose an item identifier to show nitrogen values")
            .disabled(selectedFruit.isEmpty)
            
            Button(action: {
                getnitrogenValues()
            }, label: {
                Text("Show Nitrogen Values")
            })
            .disabled(selectedID.isEmpty)
            .padding()
            .accessibilityIdentifier("showNitrogenValuesButton")
            .accessibilityLabel("Show nitrogen values")
            .accessibilityHint("Displays nitrogen measurements for the selected item")
            
            if !nitrogenValues.isEmpty {
                NitrogenLineChartView(data: nitrogenValues)
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
    
    private func getnitrogenValues() {
        nitrogenValues.removeAll()
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
                    let nitrogenValue = document.data()["Nitrogen"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), nitrogenValue))
                }
                self.nitrogenValues = values.sorted { $0.0 < $1.0 }
            }
    }
}

struct NitrogenView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 10.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 12.5),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 11.0),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 13.0),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 12.0),
            (now, 14.0)
        ]
        NavigationStack {
            NitrogenLineChartView(data: sample)
                .frame(height: 320)
                .padding()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
