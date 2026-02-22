//
//  ForgotPasswordView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var newpwd: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var showSuccess: Bool = false
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Email Address")
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.never)
            Text("New Password")
                SecureTextFieldView(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.never)
                Text("Confirm New Password")
                ReSecureTextFieldView(text: $newpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.never)
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
            
            Button {
                if email.isEmpty {
                    errorMessage = "Please enter your email address."
                    showError = true
                } else if pwd.isEmpty {
                    errorMessage = "Please enter a new password."
                    showError = true
                } else if pwd != newpwd {
                    errorMessage = "Password does not match. Try again."
                    showError = true
                } else {
                    resetPassword()
                }
            }
            label: {
                Text("Send Verification Link")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                    .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .font(.system(size: 20))
                    .padding(.top)
        }
        .padding()
        .alert("Success", isPresented: $showSuccess) {
            Button("OK") {
                // User can now sign in with new password
            }
        } message: {
            Text("Your password has been successfully reset. You can now sign in with your new password.")
        }
    }
    
    private func resetPassword() {
        // Find user by email
        guard let userIndex = appData.userData.firstIndex(where: { $0.emailAccount == email }) else {
            errorMessage = "No account found with this email address."
            showError = true
            return
        }
        
        // Update password
        appData.userData[userIndex].password = pwd
        appData.saveData()
        
        // Show success message
        showError = false
        showSuccess = true
        
        // Clear fields
        email = ""
        pwd = ""
        newpwd = ""
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(ApplicationData())
    }
}
