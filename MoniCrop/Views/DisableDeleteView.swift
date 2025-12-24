//
//  DisableDeleteView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import Firebase

struct DisableDeleteView: View {
    
    @State private var selectedAction = "Disable Account"
    @State private var password = ""
    @AppStorage("status") private var isLoggedIn: Bool = false
    @State private var didPerformAction = false
    @State private var actionMessage: String = ""
    @State private var showFailure = false
    @State private var failureMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Disable or Delete Account")
                .foregroundColor(Color.accent)
                .titleStyle()
                .padding()

                VStack(alignment: .leading, spacing: 12) {
                
                    Picker(selection: $selectedAction, label: Text("Choose Action")) {
                        Text("Disable Account").tag("Disable Account")
                        Text("Delete Account").tag("Delete Account")
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("Please enter the password to confirm:")
                        .headerStyle()
                    
                    SecureTextFieldView(text: $password).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.never)
                        .bodyStyle()
                    
                    Text("Kindly note that if you choose: \nDisable: The account will be disabled & the user can reactivate it at any moment by logging again. \nDelete: The account will be deleted instantly.")
                        .multilineTextAlignment(.leading)
                        .bodyStyle()
                        .padding()
                    
                            Button(action: {
                            guard let currentUser = Auth.auth().currentUser else { return }
                            
                            switch selectedAction {
                            case "Disable Account":
                                // Sign out the user to "disable" their account
                                do {
                                    try Auth.auth().signOut()
                                    // defer root-switch until user acknowledges
                                    actionMessage = "Account disabled (signed out)."
                                    didPerformAction = true
                                } catch let signOutError {
                                    failureMessage = "Error disabling account: \(signOutError.localizedDescription)"
                                    showFailure = true
                                }
                            case "Delete Account":
                                let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: password)
                                currentUser.reauthenticate(with: credential) { authDataResult, error in
                                    if let error = error {
                                        failureMessage = "Error reauthenticating user: \(error.localizedDescription)"
                                        showFailure = true
                                        return
                                    }
                                    currentUser.delete { error in
                                        if let error = error {
                                            failureMessage = "Error deleting account: \(error.localizedDescription)"
                                            showFailure = true
                                            return
                                        }
                                        actionMessage = "Account deleted."
                                        didPerformAction = true
                                    }
                                }
                            default:
                                break
                            }
                            
                        }) {
                            Text("Perform Action")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .primaryButtonStyle()
                        .bodyStyle()
                        .padding(.top)
                        .accessibilityLabel("Perform selected account action")
                        .accessibilityIdentifier("performAccountAction")
                        .accessibilityHint("Performs the currently selected account action, disable or delete")
                        .alert(actionMessage, isPresented: $didPerformAction) {
                            Button("OK") {
                                // switch root view now that user acknowledged
                                isLoggedIn = false
                                UserDefaults.standard.set(false, forKey: "status")
                                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                            }
                        }
                        .alert("Error", isPresented: $showFailure) {
                            Button("OK") {}
                        } message: {
                            Text(self.failureMessage)
                        }
                }
                    .onAppear {
                        guard let currentUser = Auth.auth().currentUser else { return }
                        selectedAction = currentUser.isEmailVerified ? "Disable Account" : "Delete Account"
                    }
            }
        }
    }
}


struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DisableDeleteView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
