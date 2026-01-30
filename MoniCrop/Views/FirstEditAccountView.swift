//
//  FirstEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct FirstEditAccountView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @State var selection: String = "Select your account type"
    let options = ["Select your account type", "Business Owner", "Farm Owner"]
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToSecond = false
    @EnvironmentObject var usersVM: UsersViewModel
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 100)
            Text("Edit Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            
            Text("Leave fields blank to keep current values")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            Text("New Email Address")
                .font(.system(size: 20))
            TextField("New Email (optional)", text: $email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .font(.system(size: 20))
            
            Text("New Password")
                .font(.system(size: 20))
            SecureTextFieldView(text: $pwd)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
            
            Text("Confirm New Password")
                .font(.system(size: 20))
            ReSecureTextFieldView(text: $cpwd)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .font(.system(size: 20))
            
            Group {
                Text("Account type")
                    .font(.system(size: 20))
                Picker("Account type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
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
        .padding()
        .padding(.top, 50)
        .onAppear {
            // Pre-fill with current user data
            if let user = usersVM.currentUser {
                selection = user.accountType.isEmpty ? "Select your account type" : user.accountType
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
        .navigationDestination(isPresented: $navigateToSecond) {
            SecondEditAccountView(email: $email, pwd: $pwd, selection: $selection)
        }
    }
    
    private func validateAndProceed() {
        // If password is being changed, validate it matches
        if !pwd.isEmpty && pwd != cpwd {
            errorMessage = "Passwords do not match. Please try again."
            showError = true
            return
        }
        
        // If email is being changed, validate format and check it's not already taken
        if !email.isEmpty {
            guard email.contains("@") && email.contains(".") else {
                errorMessage = "Please enter a valid email address."
                showError = true
                return
            }
            
            if let currentUser = usersVM.currentUser {
                if appData.userData.contains(where: { $0.emailAccount == email && $0.emailAccount != currentUser.emailAccount }) {
                    errorMessage = "An account with this email already exists."
                    showError = true
                    return
                }
            }
        }
        
        navigateToSecond = true
    }
}

struct FirstEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FirstEditAccountView()
                .environmentObject(UsersViewModel())
                .environmentObject(ApplicationData())
        }
    }
}
