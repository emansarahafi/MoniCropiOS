//
//  SecondEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct SecondEditAccountView: View {
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
    @State private var showSuccess = false
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var usersVM: UsersViewModel
    
    // Computed placeholder text showing current values
    private var currentFirstName: String {
        usersVM.currentUser?.firstName ?? "First Name"
    }
    private var currentMiddleName: String {
        usersVM.currentUser?.middleName ?? "Middle Name"
    }
    private var currentLastName: String {
        usersVM.currentUser?.lastName ?? "Last Name"
    }
    private var currentWorkplaceName: String {
        usersVM.currentUser?.workPlaceName ?? "Workplace Name"
    }
    private var currentPosition: String {
        usersVM.currentUser?.workPlacePosition ?? "Position"
    }

    var body: some View {
        VStack {
            Text("Leave fields blank to keep current values")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            Group {
                Text("First Name")
                    .font(.system(size: 20))
                TextField(currentFirstName, text: $fname)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Middle Name")
                    .font(.system(size: 20))
                TextField(currentMiddleName, text: $mname)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Last Name")
                    .font(.system(size: 20))
                TextField(currentLastName, text: $lname)
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
            TextField(currentWorkplaceName, text: $wname)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Position")
                .font(.system(size: 20))
            TextField(currentPosition, text: $position)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            
            Button(action: updateAccount) {
                Text("Update Account")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
            
            NavigationLink(destination: DisableDeleteView()) {
                Text("Disable or Delete Your Account")
            }
            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
            .font(.system(size: 20))
            .padding(.top)
        }
        .padding()
        .onAppear {
            // Only pre-fill the date since DatePicker needs a value
            if let user = usersVM.currentUser {
                date = user.date
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
        .alert("Success", isPresented: $showSuccess) {
            Button("OK") {}
        } message: {
            Text("Your account has been updated successfully.")
        }
    }
    
    private func updateAccount() {
        guard let currentUser = usersVM.currentUser else {
            errorMessage = "No user logged in."
            showError = true
            return
        }
        
        // Create updated user, keeping current values if new ones are empty
        let updatedUser = User(
            id: currentUser.id,
            emailAccount: email.isEmpty ? currentUser.emailAccount : email,
            password: pwd.isEmpty ? currentUser.password : pwd,
            accountType: selection == "Select your account type" ? currentUser.accountType : selection,
            firstName: fname.isEmpty ? currentUser.firstName : fname,
            middleName: mname.isEmpty ? currentUser.middleName : mname,
            lastName: lname.isEmpty ? currentUser.lastName : lname,
            workPlaceName: wname.isEmpty ? currentUser.workPlaceName : wname,
            workPlacePosition: position.isEmpty ? currentUser.workPlacePosition : position,
            date: date
        )
        
        // Update the user
        usersVM.updateCurrentUser(with: updatedUser, in: appData)
        showSuccess = true
    }
}

struct SecondEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondEditAccountView(email: .constant("test@example.com"), pwd: .constant("password"), selection: .constant("Farmer"))
            .environmentObject(ApplicationData())
            .environmentObject(UsersViewModel())
    }
}
