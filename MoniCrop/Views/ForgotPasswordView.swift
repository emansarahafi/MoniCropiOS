//
//  ForgotPasswordView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var newpwd: String = ""
    @State var error = ""
    @State var alert = false

    var body: some View {
        VStack {
            Image("MoniCrop")
                .accessibilityHidden(true)
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Email Address")
                .headerStyle()
            TextField("Insert Email", text: self.$email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .bodyStyle()
            Button(action: { reset() }) {
                Text("Send Verification Link").frame(maxWidth: .infinity)
                }
                .primaryButtonStyle()
                .bodyStyle()
                .autocorrectionDisabled(true)
                    .padding(.top)
                    .accessibilityLabel("Send password reset link")
                    .accessibilityIdentifier("sendResetLinkButton")
                    .accessibilityHint("Sends a password reset link to the provided email address")
        }
        .padding()
    }
    func reset() {
        guard !email.isEmpty else {
            self.error = "Email Id is empty"
            self.alert.toggle()
            return
        }
        
        guard isValidEmail(email) else {
            self.error = "Please enter a valid email address"
            self.alert.toggle()
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
            if let err = err {
                self.error = err.localizedDescription
                self.alert.toggle()
                return
            }
            
            self.error = "RESET"
            self.alert.toggle()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ForgotPasswordView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
