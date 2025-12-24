//
//  FirstSignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct FirstSignUpView: View {
    @State var date = Date()
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @State var alert = false
    @State var error = ""
    @State var isRegistered = false
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var navigateToSecond = false

    var body: some View {
        return NavigationStack {
            VStack {
                Image("MoniCrop")
                    .accessibilityHidden(true)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 60)

                Text("Sign Up")
                    .foregroundColor(Color.accent)
                    .titleStyle()
                    .padding(.top, 50)

                Group {
                    VStack(alignment: .leading) {
                        Text("Email Address")
                            .headerStyle()
                            .padding(.top, 10)
                        TextField("Insert Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .bodyStyle()
                            .accessibilityIdentifier("signUpEmailField")
                    }

                    VStack(alignment: .leading) {
                        Text("Password")
                            .headerStyle()
                        SecureTextFieldView(text: $pwd)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .bodyStyle()
                            .accessibilityIdentifier("signUpPasswordField")
                    }

                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                            .headerStyle()
                        ReSecureTextFieldView(text: $cpwd)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .bodyStyle()
                            .accessibilityIdentifier("signUpConfirmPasswordField")
                    }
                }

                Button(action: { register() }) {
                    Text("Sign Up").frame(maxWidth: .infinity)
                }
                .primaryButtonStyle()
                .bodyStyle()
                .padding(.top)
                .accessibilityLabel("Sign up")
                .accessibilityIdentifier("signUpButton")
                .accessibilityHint("Create a new account with this email and password")
            }
            .padding()
            .padding(.top, 70)
            .alert("Error", isPresented: $showFailure) {
                Button("OK") {}
            } message: {
                Text(self.error)
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("Continue") {
                    isRegistered = true
                }
            } message: {
                Text("Account created successfully.")
            }
            .navigationDestination(isPresented: $isRegistered) {
                SecondSignUpView().navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func register() {
        // Validate email is not empty
        guard !email.isEmpty else {
            self.error = "Please fill all the contents properly"
            self.showFailure = true
            return
        }
        
        // Validate email format
        guard isValidEmail(email) else {
            self.error = "Please enter a valid email address"
            self.showFailure = true
            return
        }
        
        // Validate password strength
        guard pwd.count >= 6 else {
            self.error = "Password must be at least 6 characters"
            self.showFailure = true
            return
        }
        
        // Validate passwords match
        guard pwd == cpwd else {
            self.error = "Password mismatch"
            self.showFailure = true
            return
        }
        
        Auth.auth().createUser(withEmail: self.email, password: self.pwd) { (res, err) in
            if let err = err {
                self.error = err.localizedDescription
                self.showFailure = true
                return
            }
            // show success alert, then continue to second signup page
            showSuccess = true
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}

struct FirstSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FirstSignUpView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
