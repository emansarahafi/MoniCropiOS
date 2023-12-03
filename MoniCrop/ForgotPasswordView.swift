//
//  ForgotPasswordView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct ForgotPasswordPage: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var newpwd: String = ""

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Email Address")
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("New Password")
            SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("Confirm New Password")
            ReSecureTextField(text: $newpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Button {
                if email.isEmpty && pwd != newpwd
                {
                    Text("Password does not match. Try again.").foregroundColor(.red)
                        .offset(y: -10)
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

struct ForgotPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPage()
    }
}
