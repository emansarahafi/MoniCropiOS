//
//  EditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import Firebase

struct FirstEditAccountPage: View {
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
            SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("Confirm Password")
                .font(.system(size: 20))
            ReSecureTextField(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
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
            FirstEditAccountPage()
        } else {
            SecondEditAccountPage()
        }
    }
}

struct SecondEditAccountPage: View {
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @State var isLoading: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""

    var body: some View {
        VStack {
            Group {
                Text("First Name")
                    .font(.system(size: 20))
                TextField("Insert First Name", text: $fname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Middle Name")
                    .font(.system(size: 20))
                TextField("Insert Middle Name", text: $mname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Last Name")
                    .font(.system(size: 20))
                TextField("Insert Last Name", text: $lname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
            }
            DatePicker("Date of Birth",
                        selection: $date,
                        in: ...Date(),
                        displayedComponents: [.date])
            .font(.system(size: 20))
                        .padding()
            Text("Workplace Name")
                .font(.system(size: 20))
            TextField("Insert Workplace Name", text: $wname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Position")
                .font(.system(size: 20))
            TextField("Insert Position", text: $position) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.top, 5)
            }
            
            Button {
                updateAccount()
            }
            label: {
                NavigationLink(destination: HamburgerMenu()) {
                    Text("Update Account")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
            Button {
            }
            label: {
                NavigationLink(destination: DisableDeletePage()) {
                    Text("Disable or Delete Your Account")
                }}                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
    }
    
    private func updateAccount() {
        // Reset error state
        showError = false
        errorMessage = ""
        
        // Validate required fields
        guard !fname.isEmpty else {
            showError = true
            errorMessage = "First name is required"
            return
        }
        
        guard !lname.isEmpty else {
            showError = true
            errorMessage = "Last name is required"
            return
        }
        
        guard !wname.isEmpty else {
            showError = true
            errorMessage = "Workplace name is required"
            return
        }
        
        guard !position.isEmpty else {
            showError = true
            errorMessage = "Position is required"
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            showError = true
            errorMessage = "No user is currently signed in"
            return
        }
        
        isLoading = true
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.setData([
            "firstName": fname,
            "middleName": mname,
            "lastName": lname,
            "dob": date,
            "workplaceName": wname,
            "position": position
        ], merge: true) { error in
            isLoading = false
            if let error = error {
                showError = true
                errorMessage = "Error updating account: \(error.localizedDescription)"
            } else {
                print("Account updated successfully")
            }
        }
    }
}

struct Previews_EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FirstEditAccountPage()
    }
}
