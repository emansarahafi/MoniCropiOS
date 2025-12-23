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
        NavigationStack {
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
                VStack (alignment: .leading){
                    Text("Email Address")
                        .font(.system(size: 20))
                        .padding(.top, 10)
                    TextField("Insert Email", text: $email)
                        .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                        .font(.system(size: 20))
                }

                VStack (alignment: .leading) {
                    Text("Password")
                        .font(.system(size: 20))
                    SecureTextFieldView(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                        .font(.system(size: 20))
                }

                VStack (alignment: .leading){
                    Text("Confirm Password")
                        .font(.system(size: 20))
                    ReSecureTextFieldView(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                        .font(.system(size: 20))
                }
            }

            Button(action: { register() }) {
                            Text("Sign Up").frame(maxWidth: .infinity)
                        }.buttonStyle(.borderedProminent)
                            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.top)
        
        }
            .padding()
            .padding(.top, 70)
            .alert("Error", isPresented: $showFailure) {
                Button("OK") {}
            } message: {
                Text(self.error)
            }
            .alert("Registered", isPresented: $showSuccess) {
                Button("Continue") {
                    isRegistered = true
                }
            } message: {
                Text("Account created successfully.")
            }
        }
        .navigationDestination(isPresented: $isRegistered) {
            SecondSignUpView().navigationBarBackButtonHidden(true)
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
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}

struct FirstSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSignUpView()
    }
}
