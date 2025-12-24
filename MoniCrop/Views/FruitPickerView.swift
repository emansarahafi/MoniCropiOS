//
//  FruitPickerView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct FruitPickerView: View {
    @State var selectedFruit: String = ""
    @State var fruits: [String] = []

    var body: some View {
        Picker("Select a fruit", selection: $selectedFruit) {
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit)
            }
        }
        .pickerStyle(.menu)
        .padding()
        .accessibilityIdentifier("fruitPicker")
        .accessibilityLabel("Select fruit")
        .accessibilityHint("Choose a fruit")
        .onAppear {
            guard let userId = Auth.auth().currentUser?.uid else {
                // handle the case where the user is not logged in
                return
            }
            let db = Firestore.firestore()
            db.collection("soil_data")
                .whereField("userId", isEqualTo: userId)
                .getDocuments { querySnapshot, error in
                    if error != nil {
                        // handle the error
                    } else {
                        var uniqueFruits = Set<String>()
                        querySnapshot?.documents.forEach { document in
                            let data = document.data()
                            if let fruit = data["fruit"] as? String {
                                uniqueFruits.insert(fruit)
                            }
                        }
                        fruits = Array(uniqueFruits)
                    }
                }
        }
    }
}

struct FruitPickerView_Previews: PreviewProvider {
    struct MockWrapper: View {
        @State var selected: String = "Apple"
        var body: some View {
            // Provide a mock picker UI for preview instead of triggering Firebase
            Picker("Select a fruit", selection: $selected) {
                Text("Apple").tag("Apple")
                Text("Carrot").tag("Carrot")
                Text("Mango").tag("Mango")
            }
            .pickerStyle(.menu)
            .padding()
        }
    }
    static var previews: some View {
        MockWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
