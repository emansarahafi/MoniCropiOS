//
//  SecondSignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct SecondSignUpView: View {
    @Binding var email: String
    @Binding var pwd: String
    @Binding var selection: String
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var usersVM: UsersViewModel

    var body: some View {
        VStack {
            Group {
                Text("First Name")
                    .font(.system(size: 20))
                TextField("Insert First Name", text: $fname)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Middle Name")
                    .font(.system(size: 20))
                TextField("Insert Middle Name", text: $mname)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Last Name")
                    .font(.system(size: 20))
                TextField("Insert Last Name", text: $lname)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
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
            TextField("Insert Workplace Name", text: $wname)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Position")
                .font(.system(size: 20))
            TextField("Insert Position", text: $position)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            
            Button(action: signUp) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
        }
        .padding()
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func signUp() {
        guard !fname.isEmpty && !lname.isEmpty && !wname.isEmpty && !position.isEmpty else {
            errorMessage = "Please fill in all required fields."
            showError = true
            return
        }
        
        // Create new user
        let newUser = User(
            emailAccount: email,
            password: pwd,
            accountType: selection,
            firstName: fname,
            middleName: mname,
            lastName: lname,
            workPlaceName: wname,
            workPlacePosition: position,
            date: date
        )
        
        // Add user and save to storage
        appData.addUser(newUser)
        
        // Auto-login the new user
        _ = usersVM.login(email: email, password: pwd, users: appData.userData)
    }
}

struct SecondSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSignUpView(email: .constant("test@example.com"), pwd: .constant("password"), selection: .constant("Business Owner"))
            .environmentObject(ApplicationData())
            .environmentObject(UsersViewModel())
    }
}
