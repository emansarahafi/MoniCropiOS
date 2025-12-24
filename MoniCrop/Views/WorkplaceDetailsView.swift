//
//  WorkplaceDetailsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct WorkplaceDetailsView: View {

    @State private var workplaceName: String = ""
    @State private var foundingDate: Date = Date()
    @State private var joinedDate: Date = Date()
    @State private var items: [String] = []

    var body: some View {
        VStack {
            Text("Workplace Details")
                .foregroundColor(Color.accent)
                .titleStyle()
                .fontWeight(.bold)
            
            VStack {
                Text("Workplace Name: \(workplaceName)")
                    .font(.headline)
                Text("Founding Date: \(foundingDate, style: .date)")
                    .font(.subheadline)
                Text("Joined MoniCrop on: \(joinedDate, style: .date)")
                    .font(.subheadline)
                Text("Items: \(items.joined(separator: ", "))")
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .bodyStyle()
            .padding()
        }
        .padding()
        .onAppear(perform: {
            // Replace "workplaces" with the name of your Firestore collection
            let db = Firestore.firestore().collection("workplaces")
            
            if let userID = Auth.auth().currentUser?.uid {
                // Retrieve the data based on the user ID
                db.whereField("userId", isEqualTo: userID).getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                        return
                    }
                    guard let documents = querySnapshot?.documents else { return }
                    for document in documents {
                        if let name = document.data()["workplaceName"] as? String {
                            self.workplaceName = name
                        }
                        if let foundingTimestamp = document.data()["foundingDate"] as? Timestamp {
                            self.foundingDate = foundingTimestamp.dateValue()
                        }
                        if let joinedTimestamp = document.data()["joinedDate"] as? Timestamp {
                            self.joinedDate = joinedTimestamp.dateValue()
                        }
                        if let items = document.data()["ownedItems"] as? [String] {
                            self.items = items
                        }
                    }
                }
            }
        })
    }
}

struct WorkplaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Workplace Details")
                .foregroundColor(Color.accent)
                .titleStyle()
                .fontWeight(.bold)
            VStack {
                Text("Workplace Name: Sample Farm")
                    .font(.headline)
                Text("Founding Date: Jan 1, 2020")
                    .font(.subheadline)
                Text("Joined MoniCrop on: Jan 2, 2020")
                    .font(.subheadline)
                Text("Items: apple, carrot")
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .bodyStyle()
            .padding()
        }
        .padding()
    }
}
