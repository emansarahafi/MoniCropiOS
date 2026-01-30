//
//  SignInView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var usersVM: UsersViewModel
    
    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Sign In")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("Email Address")
                .font(.system(size: 20))
                .padding()
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
            
            Button(action: signIn) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
            
            NavigationLink(destination: ForgotPasswordView()) {
                Text("Forgot Your Password?").underline()
            }
            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
            .font(.system(size: 20))
            
            NavigationLink(destination: FirstSignUpView()) {
                Text("Sign Up Instead")
            }
            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
            .font(.system(size: 20))
        }
        .padding()
        .padding(.top, 100)
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func signIn() {
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
        
        guard !pwd.isEmpty else {
            errorMessage = "Please enter your password."
            showError = true
            return
        }
        
        if usersVM.login(email: email, password: pwd, users: appData.userData) {
            // Login successful - ContentView will automatically switch to HamburgerMenuView
        } else {
            errorMessage = "Invalid email or password. Please try again."
            showError = true
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
                .environmentObject(ApplicationData())
                .environmentObject(UsersViewModel())
        }
    }
}
