//
//  SignInView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignInView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var alert = false
    @State var error = ""
    @AppStorage("status") private var isLoggedIn: Bool = false
    @State private var showSuccess = false
    @State private var showFailure = false
    
    var body: some View {
        NavigationStack {
            VStack {
            Image("MoniCrop")
                .accessibilityHidden(true)
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Sign In")
                .foregroundColor(Color.accent)
                .titleStyle()
            
            VStack (alignment: .leading){
                Text("Email Address")
                    .headerStyle()
                TextField("Insert Email", text: self.$email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .bodyStyle()
                    .accessibilityIdentifier("signInEmailField")
            }
            VStack (alignment: .leading){
                Text("Password")
                    .headerStyle()
                SecureTextFieldView(text: self.$pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.never)
                    .bodyStyle()
                    .accessibilityIdentifier("signInPasswordField")
            }
            Button(action: { verify() }) {
                            Text("Sign in").frame(maxWidth: .infinity)
                        }
                            .primaryButtonStyle()
                            .bodyStyle()
                            .padding(.top)
                            .accessibilityLabel("Sign in")
                            .accessibilityIdentifier("signInButton")
                            .accessibilityHint("Sign in with your email and password")
            NavigationLink(destination: ForgotPasswordView()) {
                Text("Forgot Your Password?").underline()
            }
            .foregroundColor(Color.accent)
            .bodyStyle()
            .accessibilityLabel("Forgot password")
            .accessibilityIdentifier("forgotPasswordLink")

            NavigationLink(destination: FirstSignUpView()) {
                Text("Sign Up Instead")
            }
            .foregroundColor(Color.accent)
            .bodyStyle()
            .accessibilityLabel("Sign up instead")
            .accessibilityIdentifier("signUpLink")
        }
            .padding()
            .padding(.top, 100)
            .alert("Error", isPresented: $showFailure) {
                Button("OK") {}
            } message: {
                Text(self.error)
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            } message: {
                Text("You have signed in successfully.")
            }
            // Root view will switch via `@AppStorage("status")` in App; set `isLoggedIn` on success.
        }
        }
    
    func verify() {
        // Validate input
        guard !email.isEmpty && !pwd.isEmpty else {
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
        
        Auth.auth().signIn(withEmail: self.email, password: self.pwd) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                self.showFailure = true
                return
            }
            // If the user is authenticated successfully, change the view to HomeView()
            // Show success alert, then switch root when user confirms
            showSuccess = true
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
        }
        NavigationStack {
            SignInView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
