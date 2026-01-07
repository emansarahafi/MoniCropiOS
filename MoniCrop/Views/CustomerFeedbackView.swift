//  CustomerFeedbackView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct CustomerFeedbackView: View {
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
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
            Text("Feedback or Complaint")
                .font(.system(size: 20))
            TextField("Insert Opinion", text: $opinion)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
            Button {
            } label: {
                NavigationLink(destination: ConfirmationView(email: $email).navigationBarBackButtonHidden(true)) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
        }
        .padding()
    }
}

struct CustomerFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { CustomerFeedbackView() }
    }
}