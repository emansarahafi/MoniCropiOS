//
//  CustomerView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct CustomerFeedbackPage: View {
    @State var email: String = ""
    @State var opinion: String = ""

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Customer Feedback")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Email Address")
                .font(.system(size: 20))
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("Feedback or Complaint")
                .font(.system(size: 20))
            TextField("Insert Opinion", text: $opinion) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Button {
            }
            label: {
                NavigationLink(destination: ConfirmationPage(email: $email).navigationBarBackButtonHidden(true)) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
    }
}

struct ConfirmationPage: View {
    @Binding var email: String

    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .imageScale(.large)
                .font(.system(size: 120))
                .padding()
            Text("Feedback Received!")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .padding()
            .padding()
            Button {
            }
            label: {
                NavigationLink(destination: HamburgerMenu(email: $email).navigationBarBackButtonHidden(true)) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
    }
}

struct CustomerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerFeedbackPage()
    }
}
