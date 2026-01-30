//
//  DisableDeleteView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct DisableDeleteView: View {
    @State var option = ""
    @State var pwd = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showConfirmation = false
    @EnvironmentObject var usersVM: UsersViewModel
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Text("Delete / Disable Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Choose an option:")
                .font(.system(size: 20))
            HStack {
                RadioButtonFieldView(
                    id: "Disable",
                    label: "Disable",
                    color: .black,
                    bgColor: .black,
                    textSize: 20,
                    isMarked: option == "Disable",
                    callback: { selected in
                        self.option = selected
                    }
                )
                RadioButtonFieldView(
                    id: "Delete",
                    label: "Delete",
                    color: .black,
                    bgColor: .black,
                    textSize: 20,
                    isMarked: option == "Delete",
                    callback: { selected in
                        self.option = selected
                    }
                )
            }
            .padding()
            
            Text("Please enter your password to confirm:")
                .font(.system(size: 20))
            SecureTextFieldView(text: $pwd)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .font(.system(size: 20))
            
            Text("Kindly note that if you choose: \nDisable: The account will be disabled & you can reactivate it at any moment by logging in again. \nDelete: The account will be permanently deleted.")
                .multilineTextAlignment(.leading)
                .font(.system(size: 20))
                .padding()
            
            Button(action: performAction) {
                Text("Confirm")
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
        .alert("Success", isPresented: $showConfirmation) {
            Button("OK") {
                if option == "Delete" {
                    usersVM.deleteCurrentUser(from: appData)
                } else {
                    usersVM.logout()
                }
            }
        } message: {
            Text(option == "Delete" ? "Your account has been deleted." : "Your account has been disabled. Log in again to reactivate.")
        }
    }
    
    private func performAction() {
        guard !option.isEmpty else {
            errorMessage = "Please select an option."
            showError = true
            return
        }
        
        guard !pwd.isEmpty else {
            errorMessage = "Please enter your password to confirm."
            showError = true
            return
        }
        
        guard let currentUser = usersVM.currentUser, currentUser.password == pwd else {
            errorMessage = "Incorrect password. Please try again."
            showError = true
            return
        }
        
        showConfirmation = true
    }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DisableDeleteView()
            .environmentObject(UsersViewModel())
            .environmentObject(ApplicationData())
    }
}

