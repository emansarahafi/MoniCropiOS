//
//  TemperatureView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 4/23/23.
//

import SwiftUI
import Firebase

struct TemperatureView: View {
    @State private var selectedFruit = ""
    @State private var temperatureValues: [(Date, Double)] = []
    @State private var fruits: [String] = []
    
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
            .accessibilityIdentifier("temperaturePickerFruit")
            .accessibilityLabel("Select crop item for temperature")
            .accessibilityHint("Choose a crop to show temperature values")
            
            Button(action: {
                gettemperatureValues()
            }, label: {
                Text("Show temperature Values")
            })
            .disabled(selectedFruit.isEmpty)
            .padding()
            .accessibilityIdentifier("showTemperatureValuesButton")
            .accessibilityLabel("Show temperature values")
            .accessibilityHint("Displays temperature measurements for the selected crop")
            
            if !temperatureValues.isEmpty {
                TemperatureLineChartView(data: temperatureValues)
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
    
    private func gettemperatureValues() {
        temperatureValues.removeAll()
        db.collection("soil_data")
            .whereField("userId", isEqualTo: user?.uid ?? "")
            .whereField("fruit", isEqualTo: selectedFruit)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                var values: [(Date, Double)] = []
                for document in documents {
                    let temperatureValue = document.data()["Temperature"] as? Double ?? 0.0
                    let timestamp = document.data()["Timestamp"] as? Timestamp ?? Timestamp()
                    values.append((timestamp.dateValue(), temperatureValue))
                }
                self.temperatureValues = values.sorted { $0.0 < $1.0 }
            }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let sample: [(Date, Double)] = [
            (Calendar.current.date(byAdding: .day, value: -5, to: now)!, 18.0),
            (Calendar.current.date(byAdding: .day, value: -4, to: now)!, 20.5),
            (Calendar.current.date(byAdding: .day, value: -3, to: now)!, 19.0),
            (Calendar.current.date(byAdding: .day, value: -2, to: now)!, 22.0),
            (Calendar.current.date(byAdding: .day, value: -1, to: now)!, 21.5),
            (now, 23.0)
        ]
        NavigationStack {
            TemperatureLineChartView(data: sample)
                .frame(height: 320)
                .padding()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
