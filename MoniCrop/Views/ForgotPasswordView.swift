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
                    showError = false
                    // TODO: Send verification link
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
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
