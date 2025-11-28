//
//  SignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct FirstSignUpPage: View {
    @State var date = Date()
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @State var alert = false
    @State var error = ""
    @State var isRegistered = false

    var body: some View {
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
                    SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                        .font(.system(size: 20))
                }
                VStack (alignment: .leading){
                    Text("Confirm Password")
                        .font(.system(size: 20))
                    ReSecureTextField(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                        .font(.system(size: 20))
                }
            }
            Button(action: { register() }) {
                            Text("Sign Up")
                        }.buttonStyle(.borderedProminent)
                            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.top)
        
        }
        .padding()
        .padding(.top, 70)
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.error), dismissButton: .default(Text("OK")))
        }
        .background(
            NavigationLink(destination: SecondSignUpPage(), isActive: $isRegistered) {
                FirstSignUpPage()
            }
        )
    }
    func register() {
        // Validate email is not empty
        guard !email.isEmpty else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
            return
        }
        
        // Validate email format
        guard isValidEmail(email) else {
            self.error = "Please enter a valid email address"
            self.alert.toggle()
            return
        }
        
        // Validate password strength
        guard pwd.count >= 6 else {
            self.error = "Password must be at least 6 characters"
            self.alert.toggle()
            return
        }
        
        // Validate passwords match
        guard pwd == cpwd else {
            self.error = "Password mismatch"
            self.alert.toggle()
            return
        }
        
        Auth.auth().createUser(withEmail: self.email, password: self.pwd) { (res, err) in
            if let err = err {
                self.error = err.localizedDescription
                self.alert.toggle()
                return
            }
            isRegistered = true
            
            UserDefaults.standard.set(true, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}

struct SecondSignUpPage: View {
    @State var selection = "Select your account type"
    let options = ["Select your account type", "Business Owner", "Farm Owner"]
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @State var email: String = ""
    @State var isSaved = false

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
            Group {
                Text("Account type")
                    .font(.system(size: 20))
                Picker("Account type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.system(size: 20))
                Text("Workplace Name")
                    .font(.system(size: 20))
                TextField("Insert Workplace Name", text: $wname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Position")
                    .font(.system(size: 20))
                TextField("Insert Position", text: $position) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Button(action: {
                    saveUserData()
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                    .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.top)
            }
            .padding()
            .background(
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isSaved) {
                    SecondSignUpPage()
                }
            )
        }
    }
    func saveUserData() {
        // Validate required fields
        guard !fname.isEmpty, !lname.isEmpty, !wname.isEmpty, !position.isEmpty else {
            print("Please fill all required fields")
            return
        }
        
        // Validate account type selection
        guard selection != "Select your account type" else {
            print("Please select an account type")
            return
        }
        
        // Get the current user's ID and email
        guard let userID = Auth.auth().currentUser?.uid, let userEmail = Auth.auth().currentUser?.email else {
            print("No user is currently signed in")
            return
        }
        
        // Get a reference to the "users" collection and the document with the user's ID
        let userRef = Firestore.firestore().collection("users").document(userID)
        
        // Set the document data with the user's details
        userRef.setData([
            "email": userEmail,
            "firstName": fname,
            "middleName": mname,
            "lastName": lname,
            "dob": date,
            "accountType": selection,
            "workplaceName": wname,
            "position": position
        ]) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully!")
                isSaved = true
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSignUpPage()
    }
}
