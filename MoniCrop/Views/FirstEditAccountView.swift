//
//  FirstEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import Firebase

enum EditAction {
    case delete
}

struct FirstEditAccountView: View {
    var onComplete: ((EditAction) -> Void)? = nil
    @EnvironmentObject var usersVM: UsersViewModel
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @State var showError: Bool = false
    @State var errorMessage: String = ""

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Edit Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("Email Address")
                .font(.system(size: 20))
                .padding()
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Insert Password")
                .font(.system(size: 20))
            SecureTextFieldView(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("Confirm Password")
                .font(.system(size: 20))
            ReSecureTextFieldView(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.top, 5)
            }
            
            Button {
                validateAndProceed()
            }
            label: {
                NavigationLink(destination: chooseDestination()) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
        .padding(.top, 50)
    }
    
    private func validateAndProceed() {
        // Reset error state
        showError = false
        errorMessage = ""
        
        // Validate passwords match
        if !pwd.isEmpty && pwd != cpwd {
            showError = true
            errorMessage = "Passwords do not match"
            return
        }
        
        // Validate password length if provided
        if !pwd.isEmpty && pwd.count < 6 {
            showError = true
            errorMessage = "Password must be at least 6 characters"
            return
        }
        
        // Validate email format if provided
        if !email.isEmpty && !isValidEmail(email) {
            showError = true
            errorMessage = "Please enter a valid email address"
            return
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @ViewBuilder
    func chooseDestination() -> some View {
        if (!email.isEmpty && !isValidEmail(email)) || (!pwd.isEmpty && pwd != cpwd) || (!pwd.isEmpty && pwd.count < 6) {
            FirstEditAccountView(onComplete: onComplete).environmentObject(usersVM)
        } else {
            SecondEditAccountView(onComplete: onComplete).environmentObject(usersVM)
        }
    }
}

struct FirstEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstEditAccountView(onComplete: nil).environmentObject(UsersViewModel(user: User()))
    }
}
