//
//  FirstSignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct FirstSignUpView: View {
    @State var selection = "Select your account type"
    let options = ["Select your account type", "Business Owner", "Farm Owner"]
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToSecond = false
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 60)
            Text("Sign Up")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 50)
            Group {
                Text("Email Address")
                    .font(.system(size: 20))
                    .padding(.top, 10)
                TextField("Insert Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .font(.system(size: 20))
                Text("Password")
                    .font(.system(size: 20))
                SecureTextFieldView(text: $pwd)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 20))
                Text("Confirm Password")
                    .font(.system(size: 20))
                ReSecureTextFieldView(text: $cpwd)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 20))
            }
            Group {
                Text("Account type")
                    .font(.system(size: 20))
                Picker("Account type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.system(size: 20))
                
                Button(action: validateAndProceed) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.top)
            }
        }
        .padding()
        .padding(.top, 70)
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
        .navigationDestination(isPresented: $navigateToSecond) {
            SecondSignUpView(email: $email, pwd: $pwd, selection: $selection)
        }
    }
    
    private func validateAndProceed() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            showError = true
            return
        }
        
        // Validate email format
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address."
            showError = true
            return
        }
        
        guard !pwd.isEmpty else {
            errorMessage = "Please enter a password."
            showError = true
            return
        }
        
        guard pwd.count >= 4 else {
            errorMessage = "Password must be at least 4 characters."
            showError = true
            return
        }
        
        guard pwd == cpwd else {
            errorMessage = "Passwords do not match. Please try again."
            showError = true
            return
        }
        
        guard selection != "Select your account type" else {
            errorMessage = "Please select an account type."
            showError = true
            return
        }
        
        // Check if email already exists
        if appData.userData.contains(where: { $0.emailAccount == email }) {
            errorMessage = "An account with this email already exists."
            showError = true
            return
        }
        
        navigateToSecond = true
    }
}

struct FirstSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FirstSignUpView()
                .environmentObject(ApplicationData())
        }
    }
}
