//
//  WelcomeView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct HamburgerMenu: View {
    @State var showMenu = false
    @Binding var email: String
        
        var body: some View {
            
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
                            self.showMenu = false
                        }
                    }
                }
            
            return NavigationView {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        MainPage(email: $email)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/1.25 : 0)
                            .disabled(self.showMenu ? true : false)
                        if self.showMenu {
                            MenuView()
                                .frame(width: geometry.size.width/1.25)
                                .transition(.move(edge: .leading))
                        }
                    }
                        .gesture(drag)
                }
                    .navigationBarItems(leading: (
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.black)
                                .imageScale(.large)
                        }
                    ))
        }
    }
}

struct MainPage: View {
    @Binding var email: String
    var body: some View {
        VStack(spacing: 50) {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Welcome")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("\(Text("Account Email: ").bold().foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255)))\(email)")
                .foregroundColor(Color.black)
                .font(.system(size: 20))
        }
        .padding()
    }
}

struct MenuView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
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
                        NavigationLink(destination: ViewItemsPage()) {
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
                        NavigationLink(destination: ViewDataPage()) {
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
                        NavigationLink(destination: WorkplaceDetailsPage()) {
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
                        NavigationLink(destination: CustomerFeedbackPage()) {
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
                        openURL(URL(string: "https://www.apple.com")!)
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
                        openURL(URL(string: "https://www.apple.com")!)
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
                        NavigationLink(destination: FirstEditAccountPage()) {
                            Text("Edit Account")
                        }}.foregroundColor(.black)
                            .font(.headline)
                }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .imageScale(.large)
                    Button {
                    }
                    label: {
                        NavigationLink(destination: LandingPage().navigationBarBackButtonHidden(true)) {
                            Text("Log Out")
                        }}.foregroundColor(.black)
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

