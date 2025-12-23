//
//  SecondEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase

struct SecondEditAccountView: View {
    var onComplete: ((EditAction) -> Void)? = nil
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @State var isLoading: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State private var navigateToMenu = false
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var failureMessage = ""

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

            // hidden navigation link controlled by update success

            Button {
                updateAccount()
            } label: {
                Text("Update Account")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.top)
            .alert("Saved", isPresented: $showSuccess) {
                Button("Continue") {
                    navigateToMenu = true
                }
            } message: {
                Text("Account updated successfully.")
            }
            .alert("Error", isPresented: $showFailure) {
                Button("OK") {}
            } message: {
                Text(self.failureMessage)
            }
            Button {
                // Signal deletion intent to caller (e.g. parent sheet)
                onComplete?(.delete)
            } label: {
                Text("Disable or Delete Your Account")
            }
            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
            .font(.system(size: 20))
            .padding(.top)
        }
        .padding()
        .navigationDestination(isPresented: $navigateToMenu) {
            HamburgerMenuView()
        }
    }

    private func updateAccount() {
        // Reset error state
        showError = false
        errorMessage = ""

        // Validate required fields
        guard !fname.isEmpty else {
            failureMessage = "First name is required"
            showFailure = true
            return
        }

        guard !lname.isEmpty else {
            failureMessage = "Last name is required"
            showFailure = true
            return
        }

        guard !wname.isEmpty else {
            failureMessage = "Workplace name is required"
            showFailure = true
            return
        }

        guard !position.isEmpty else {
            failureMessage = "Position is required"
            showFailure = true
            return
        }

        guard let user = Auth.auth().currentUser else {
            failureMessage = "No user is currently signed in"
            showFailure = true
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
                failureMessage = "Error updating account: \(error.localizedDescription)"
                showFailure = true
            } else {
                DispatchQueue.main.async {
                    showSuccess = true
                }
            }
        }
    }
}

struct SecondEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondEditAccountView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
