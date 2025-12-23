//
//  MenuView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @Environment(\.openURL) var openURL
    // No local navigation needed; sign-out will update app root via AppStorage
    var body: some View {
        NavigationStack {
            VStack {
            Text("Main Menu")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            VStack (alignment: .leading ){
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: ViewItemsView()) {
                            Text("View Items")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "chart.bar")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: ViewDataView()) {
                            Text("View Data")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "book")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: WorkplaceDetailsView()) {
                            Text("View Workplace Details")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "face.smiling")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: CustomerFeedbackView()) {
                            Text("Customer Feedback")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button("View PDF Brochure") {
                        openURL(URL(string: "https://www.canva.com/design/DAFOn23KpfE/Eueuve2e40uBRa0V7cRz9w/view?utm_content=DAFOn23KpfE&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink")!)
                    }
                        .foregroundColor(.black)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button("Access Telegram Channel") {
                        openURL(URL(string: "https://t.me/MoniCropFeedback")!)
                    }
                        .foregroundColor(.black)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: FirstEditAccountView()) {
                            Text("Edit Account")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                            shouldShowLandingPage = true
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }) {
                        Text("Sign Out")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .edgesIgnoringSafeArea(.all)
                // sign-out updates AppStorage("status") and switches root; no local navigation required
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
