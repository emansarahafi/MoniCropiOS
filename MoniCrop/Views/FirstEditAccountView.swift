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
    @State private var navigate = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Edit Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
            Text("Email Address")
                .font(.system(size: 20))
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
            }
            
            // show inline error no longer used; show alert instead

            Button(action: {
                if validate() {
                    navigate = true
                } else {
                    showAlert = true
                }
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
            .alert("Validation", isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
        .padding()
        .padding(.top, 50)
        .navigationDestination(isPresented: $navigate) {
            SecondEditAccountView(onComplete: onComplete).environmentObject(usersVM)
        }
    }
    
    private func validate() -> Bool {
        // Reset error state
        showError = false
        errorMessage = ""
        alertMessage = ""

        // Validate passwords match
        if !pwd.isEmpty && pwd != cpwd {
            alertMessage = "Passwords do not match"
            return false
        }

        // Validate password length if provided
        if !pwd.isEmpty && pwd.count < 6 {
            alertMessage = "Password must be at least 6 characters"
            return false
        }

        // Validate email format if provided
        if !email.isEmpty && !isValidEmail(email) {
            alertMessage = "Please enter a valid email address"
            return false
        }

        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }    
}

struct FirstEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstEditAccountView(onComplete: nil).environmentObject(UsersViewModel(user: User()))
    }
}
