//
//  MenuView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var usersVM: UsersViewModel
    
    var body: some View {
        VStack {
            Text("Main Menu")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    NavigationLink(destination: ViewItemsView()) {
                        Text("View Items")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                
                HStack {
                    Image(systemName: "chart.bar")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    NavigationLink(destination: ViewDataView()) {
                        Text("View Data")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                
                HStack {
                    Image(systemName: "book")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    NavigationLink(destination: WorkplaceDetailsView()) {
                        Text("View Workplace Details")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                
                HStack {
                    Image(systemName: "face.smiling")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    NavigationLink(destination: CustomerFeedbackView()) {
                        Text("Customer Feedback")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                
                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button("View PDF Brochure") {
                        if let url = URL(string: "https://www.apple.com") {
                            openURL(url)
                        }
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
                        if let url = URL(string: "https://www.apple.com") {
                            openURL(url)
                        }
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
                    NavigationLink(destination: FirstEditAccountView()) {
                        Text("Edit Account")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
                
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button("Log Out") {
                        usersVM.logout()
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                .padding(.top, 30)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
                .environmentObject(UsersViewModel())
        }
    }
}
