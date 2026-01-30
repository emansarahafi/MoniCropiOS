//  CustomerFeedbackView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct CustomerFeedbackView: View {
    @EnvironmentObject var usersVM: UsersViewModel
    @State private var email: String = ""
    @State private var opinion: String = ""
    @State private var showConfirmation = false
    @State private var showError = false
    @State private var errorMessage = ""

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
                .textInputAutocapitalization(.never)
            Text("Feedback or Complaint")
                .font(.system(size: 20))
            TextField("Insert Opinion", text: $opinion)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.sentences)
            Button {
                submitFeedback()
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
        }
        .padding()
        .onAppear {
            if let user = usersVM.currentUser {
                email = user.emailAccount
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
        .navigationDestination(isPresented: $showConfirmation) {
            ConfirmationView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private func submitFeedback() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            showError = true
            return
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address."
            showError = true
            return
        }
        
        guard !opinion.isEmpty else {
            errorMessage = "Please enter your feedback."
            showError = true
            return
        }
        
        showConfirmation = true
    }
}

struct CustomerFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerFeedbackView()
                .environmentObject(UsersViewModel())
        }
    }
}